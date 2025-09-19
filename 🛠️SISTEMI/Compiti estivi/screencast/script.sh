#!/usr/bin/env bash
set -euo pipefail

# File names
SRC="simple_v2.c"
BIN="simple_v2_dbg_bin"
OUT_RAW="raw_dump.txt"
OUT_GDB="gdb_dump.txt"
OUT_MD="simple_v2_analysis.md"
OUT_JSON="simple_v2_analysis.json"

# Check dependencies
deps=(gcc readelf nm objdump gdb python3 setarch hexdump)
miss=()
for d in "${deps[@]}"; do
  if ! command -v "$d" >/dev/null 2>&1; then
    miss+=("$d")
  fi
done
if [ "${#miss[@]}" -ne 0 ]; then
  echo "Errore: mancano i seguenti strumenti: ${miss[*]}" >&2
  echo "Installa con: sudo apt install build-essential binutils gdb python3 util-linux" >&2
  exit 1
fi

# Clean old outputs
rm -f "$BIN" "$OUT_RAW" "$OUT_GDB" "$OUT_MD" "$OUT_JSON"

echo "=== COMPILAZIONE (no PIE, con frame pointer, debug) ===" | tee "$OUT_RAW"
gcc -no-pie -g -fno-omit-frame-pointer "$SRC" -o "$BIN" 2>&1 | tee -a "$OUT_RAW"

echo -e "\n=== SEZIONI ELF (readelf -S) ===" | tee -a "$OUT_RAW"
readelf -S "$BIN" 2>&1 | tee -a "$OUT_RAW"

echo -e "\n=== SYMBOLS (readelf -s) ===" | tee -a "$OUT_RAW"
readelf -s "$BIN" 2>&1 | tee -a "$OUT_RAW"

echo -e "\n=== NM (sorted symbols) ===" | tee -a "$OUT_RAW"
nm -n "$BIN" 2>&1 | tee -a "$OUT_RAW"

echo -e "\n=== SIZE ===" | tee -a "$OUT_RAW"
size "$BIN" 2>&1 | tee -a "$OUT_RAW"

echo -e "\n=== OBJDUMP -h (section headers) ===" | tee -a "$OUT_RAW"
objdump -h "$BIN" 2>&1 | tee -a "$OUT_RAW"

echo -e "\n=== DUMP BYTES .rodata (readelf -x) ===" | tee -a "$OUT_RAW"
readelf -x .rodata "$BIN" 2>&1 | tee -a "$OUT_RAW"

# Run program once normally (with ASLR disabled for reproducibility)
echo -e "\n=== ESECUZIONE NORMALE (setarch -R per disabilitare ASLR) ===" | tee -a "$OUT_RAW"
setarch "$(uname -m)" -R ./"$BIN" 2>&1 | tee -a "$OUT_RAW"

# Now run under gdb and break in memoryLayout to capture stack/heap precisely
echo -e "\n=== ESECUZIONE sotto GDB per dump stack & memoria ===" | tee -a "$OUT_RAW"
cat > gdb_cmds.txt <<'GDBCMDS'
set pagination off
set confirm off
break memoryLayout
run
# print registers of interest
p/x $rbp
p/x $rsp
p/x $rip
# dump 64 qwords from rbp (to inspect saved rbp, retaddr, locals)
x/64gx $rbp
# dump 256 bytes starting at rsp (stack area)
x/256bx $rsp
# print addresses of key globals (use symbol names)
p &exename
p exename
p &tot_cc
p tot_cc
p &rubr_dyn
# dump first 16 pointers of rubr_dyn array (8 bytes each)
x/16gx &rubr_dyn
# attempt to read strings pointed by first 5 rubr_dyn slots
printf "=== strings at rubr_dyn[0..4] ===\n"
p rubr_dyn[0]
p rubr_dyn[1]
p rubr_dyn[2]
p rubr_dyn[3]
p rubr_dyn[4]
# continue and quit
continue
quit
GDBCMDS

# Run gdb in batch mode with ASLR disabled for reproducibility
setarch "$(uname -m)" -R gdb --batch -nx -q -ex "source gdb_cmds.txt" ./"$BIN" > "$OUT_GDB" 2>&1 || true
echo "GDB dump saved to $OUT_GDB" | tee -a "$OUT_RAW"

# Dump the .rodata raw bytes to a file for parsing
objcopy --dump-section .rodata=rodata.bin "$BIN"
hexdump -C rodata.bin > rodata_hexdump.txt
echo -e "\n(rodata dumped to rodata.bin, hexdump in rodata_hexdump.txt)" | tee -a "$OUT_RAW"

# Now invoke Python parser to synthesize the final markdown and json
echo -e "\n=== GENERAZIONE REPORT (Python) ===" | tee -a "$OUT_RAW"

python3 - <<'PY' 2>&1 | tee -a "$OUT_RAW"
import re, json, subprocess, sys, os

# Utility to read files
def read(path):
    with open(path, 'r', encoding='utf-8', errors='ignore') as f:
        return f.read()

raw = read("raw_dump.txt")
gdb = read("gdb_dump.txt")
rodata_hex = read("rodata_hexdump.txt")

report = []
js = {}

report.append("# MAPPA PRECISA DELLA MEMORIA - simple_v2 (analisi reale, dettagliata)\n")
report.append("**NOTE:** Esecuzione con ASLR disabilitato (setarch -R) per indirizzi ripetibili.\n\n")

# --- parse sections from readelf -S in raw_dump.txt
report.append("## Sezioni ELF (readelf -S)\n\n")
sec_match = re.search(r"Section Headers:\n-+\n(.*?)(\n\n|Key to)", raw, re.S)
sections = []
if sec_match:
    sec_text = sec_match.group(1)
    for line in sec_text.splitlines():
        m = re.search(r"\s*\[\s*\d+\]\s+(\.\S+)\s+.*?([0-9a-fA-Fx]+)\s+([0-9a-fA-Fx]+)\s+([0-9a-fA-Fx]+)\s", line)
        if m:
            name = m.group(1)
            addr = int(m.group(2),16)
            size = int(m.group(3),16)
            sections.append({"name":name,"addr":addr,"size":size})
            report.append(f"- **{name}**: addr=0x{addr:016x}, size=0x{size:x} ({size} bytes)\n")
js['sections'] = sections

# --- parse symbols (readelf -s)
report.append("\n## Symbol table (estratta da readelf -s / nm)\n\n")
symbols = []
for line in raw.splitlines():
    # look for nm -n lines like: 0000000000401150 T add_cc
    m = re.match(r"\s*([0-9a-fA-F]+)\s+([A-Za-z])\s+(.+)$", line)
    if m and len(m.group(3).strip().split())==1:
        addr = int(m.group(1),16)
        typ = m.group(2)
        name = m.group(3).strip()
        symbols.append({"name":name,"addr":addr,"type":typ})
# supplement with readelf lines for sizes
for line in raw.splitlines():
    m = re.match(r"\s*\d+:\s*([0-9a-fA-F]+)\s+([0-9a-fA-F]+)\s+(\S+)\s+(\S+)\s+\S+\s+\d+\s+(.+)$", line)
    if m:
        addr = int(m.group(1),16)
        size = int(m.group(2),16)
        name = m.group(5).strip()
        # find existing entry or append
        found=False
        for s in symbols:
            if s['name']==name:
                s['size']=size
                s['addr']=addr
                found=True
                break
        if not found:
            symbols.append({"name":name,"addr":addr,"size":size,"type":"?"})
# present top-level functions we expect
sym_interest = ["add_cc","printrub","memoryLayout","main","exename","tot_cc","rubr_dyn"]
for s in sorted(symbols, key=lambda x: x.get('addr',0)):
    if s['name'] in sym_interest or s['type'] in ('T','t','W'):
        sz = s.get('size',0)
        report.append(f"- {s['name']:20s} addr=0x{s['addr']:016x} size=0x{sz:x} ({sz} bytes)\n")
js['symbols']=symbols

# --- extract runtime printed pointers from raw_dump.txt (program stdout)
report.append("\n## Indirizzi runtime catturati (output del programma)\n\n")
runtime = {}
for line in raw.splitlines():
    if ".text  funzione memoryLayout" in line:
        m = re.search(r":\s*(0x[0-9a-fA-F]+)", line)
        if m: runtime['memoryLayout'] = int(m.group(1),16)
    if ".rodata exename (stringa):" in line:
        m = re.search(r":\s*(0x[0-9a-fA-F]+)\s*->\s*(.*)$", line)
        if m:
            runtime['exename_addr']=int(m.group(1),16)
            runtime['exename_val']=m.group(2).strip()
    if ".data   &tot_cc" in line:
        m = re.search(r":\s*(0x[0-9a-fA-F]+)\s*->\s*(\d+)", line)
        if m:
            runtime['tot_cc_addr']=int(m.group(1),16)
            runtime['tot_cc_val']=int(m.group(2))
    if ".bss    rubr_dyn[0]" in line:
        m = re.search(r":\s*(0x[0-9a-fA-F]+)\s*->\s*(0x[0-9a-fA-F]+|non ancora)", line)
        if m:
            runtime['rubr_dyn_slot']=int(m.group(1),16)
            val = m.group(2)
            runtime['rubr_dyn0_val']= None if "non" in val else int(val,16)
    if "stack  &local_var" in line:
        m = re.search(r":\s*(0x[0-9a-fA-F]+)", line)
        if m:
            runtime['stack_local_var']=int(m.group(1),16)
    if "heap  rubr_dyn[0]" in line:
        m = re.search(r"rubr_dyn\[0\]:\s*(0x[0-9a-fA-F]+)\s*->\s*(.*)$", line)
        if m:
            runtime['heap_rubr_dyn0']=int(m.group(1),16)
            runtime['heap_rubr_dyn0_val']=m.group(2).strip()
for k,v in runtime.items():
    if isinstance(v,int):
        report.append(f"- {k}: 0x{v:016x}\n")
    else:
        report.append(f"- {k}: {v}\n")
js['runtime']=runtime

# --- Parse GDB output for registers and memory dumps
report.append("\n## Dump GDB (registers + memory near RBP/RSP + rubr_dyn array)\n\n")
report.append("GDB raw (estratto):\n\n")
gdb_excerpt_lines = []
for line in gdb.splitlines():
    # collect interesting parts
    if re.search(r"\$[0-9]+ = 0x[0-9a-fA-F]+", line) or re.search(r"0x[0-9a-fA-F]+:\t", line) or "strings at rubr_dyn" in line or "rubr_dyn" in line or "exename" in line:
        gdb_excerpt_lines.append(line)
# Append a short excerpt (first 400 lines)
report.append("```\n")
report.append("\n".join(gdb_excerpt_lines[:400]))
report.append("\n```\n\n")
js['gdb_excerpt'] = gdb_excerpt_lines

# --- Parse .rodata bytes to extract strings with offsets
report.append("## .rodata — offset, addr, string (estratto da rodata_hexdump.txt)\n\n")
strings = []
cur_addr = None
for line in rodata_hex.splitlines():
    m = re.match(r"([0-9a-fA-F]+)\s+([0-9a-fA-F ]+)\s+\|(.+)\|", line)
    if m:
        off = int(m.group(1),16)
        ascii_part = m.group(3)
        # find null-terminated substrings
        s = ascii_part.split('\x00')[0]
        # record if plausible
        if len(s.strip())>=1 and any(c.isalpha() for c in s):
            strings.append({"offset":off,"ascii":s})
            report.append(f"- offset 0x{off:x} -> \"{s}\"\n")
js['rodata_strings']=strings

# --- Build .bss rubr_dyn table from symbols (addresses) and GDB memory dump if possible
report.append("\n## Layout .data / .bss per rubr_dyn\n\n")
# Try to find symbol address for rubr_dyn from nm/readelf in raw
m = re.search(r"\b([0-9a-fA-F]+)\s+B\s+rubr_dyn\b", raw)
bss_base = None
if m:
    bss_base = int(m.group(1),16)
    report.append(f"- rubr_dyn base address (symbol): 0x{bss_base:016x}\n")
else:
    # try other patterns
    m2 = re.search(r"rubr_dyn.*0x([0-9a-fA-F]+)", gdb)
    if m2:
        bss_base = int(m2.group(1),16)
        report.append(f"- rubr_dyn base address (gdb): 0x{bss_base:016x}\n")
if bss_base:
    slots = []
    for i in range(0,100):
        slot_addr = bss_base + i*8
        # try to find its value in gdb excerpt (we dumped x/16gx &rubr_dyn)
        # naive search: find lines with slot bytes containing slot_addr in gdb excerpt (we already saved excerpt)
        found_val = None
        for line in gdb_excerpt_lines:
            # lines like "0x404090:\t0x0000000000000000  0x0000000000000000"
            mm = re.match(r"\s*0x([0-9a-fA-F]+):\s*(.*)", line)
            if mm:
                addr_line = int(mm.group(1),16)
                if addr_line==slot_addr:
                    # parse qwords on that line
                    rest = mm.group(2).strip()
                    vals = rest.split()
                    if len(vals)>=1:
                        try:
                            found_val = int(vals[0],16)
                        except:
                            found_val=None
        slots.append({"index":i,"slot_addr":slot_addr,"value":found_val})
    js['rubr_dyn_slots']=slots
    # print table for first 10 slots
    report.append("| idx | slot addr | value (ptr) | ascii if available |\n")
    report.append("|---:|:----------:|:-----------:|:------------------|\n")
    for s in slots[:16]:
        v = s['value']
        vstr = "0x%016x" % v if v else ("NULL" if v==0 else "unknown")
        ascii = ""
        # try to find ascii for heap pointer in gdb excerpt
        if v and v!=0:
            # search printed string in gdb excerpt lines
            for line in gdb_excerpt_lines:
                if re.search(r"\".*"+re.escape(str(v))+".*\"", line):
                    ascii = line.strip()
        report.append(f"| {s['index']:2d} | 0x{s['slot_addr']:016x} | {vstr} | {ascii} |\n")
else:
    report.append("Impossibile determinare indirizzo simbolico di rubr_dyn; esegui nm -n o readelf -s.\n")

# --- Heap allocations (from program stdout earlier)
report.append("\n## Heap allocations (malloc) — indirizzi rilevati a runtime\n\n")
# try extract addresses from raw
heap_addrs = []
for line in raw.splitlines():
    m = re.search(r"rubr_dyn\[\d+\]:\s*(0x[0-9a-fA-F]+)\s*->\s*(.*)$", line)
    if m:
        addr = int(m.group(1),16)
        val = m.group(2).strip()
        heap_addrs.append({"addr":addr,"val":val})
if heap_addrs:
    for h in heap_addrs:
        report.append(f"- heap at 0x{h['addr']:016x} -> {h['val']}\n")
js['heap_addrs']=heap_addrs

# --- Stack frame reconstruction (best-effort) from GDB dump
report.append("\n## Stack frame (reconstruction best-effort)\n\n")
# try extract rbp and rsp from gdb excerpt
rbp=None; rsp=None; rip=None
for line in gdb_excerpt_lines:
    m = re.match(r"\$\d+\s+=\s+0x([0-9a-fA-F]+)", line)
    if m and rbp is None:
        # heuristics: first p/x $rbp, then p/x $rsp, then p/x $rip
        rbp = int(m.group(1),16)
        # assign subsequent ones later
        continue
# fallback scan
mrbp = re.search(r"\$[0-9]+\s+=\s+0x([0-9a-fA-F]+).*#\s*\$rbp", gdb)
if mrbp:
    rbp = int(mrbp.group(1),16)
# more robust: search explicit "p/x $rbp" result in gdb output
for line in gdb.splitlines():
    if line.strip().startswith("$") and " = 0x" in line:
        if rbp is None:
            rbp = int(line.split("= ")[1].strip(),16)
            continue

if rbp:
    report.append(f"- RBP: 0x{rbp:016x}\n")
    # try to show saved RBP and return address reading from gdb_hex if present
    # attempt to find line "0x<rbp>:    0x.... 0x...."
    for line in gdb.splitlines():
        m = re.match(r"\s*0x([0-9a-fA-F]+):\s*(0x[0-9a-fA-F]+)\s*(0x[0-9a-fA-F]+)?.*", line)
        if m:
            addr = int(m.group(1),16)
            if addr==rbp:
                saved_rbp = int(m.group(2),16)
                retaddr = int(m.group(3),16) if m.group(3) else None
                report.append(f"  - [rbp] = saved RBP -> 0x{saved_rbp:016x}\n")
                if retaddr:
                    report.append(f"  - [rbp+8] = return address -> 0x{retaddr:016x}\n")
                break

# Finalize and write files
with open("simple_v2_analysis.md","w",encoding="utf-8") as f:
    f.write("\n".join(report))

with open("simple_v2_analysis.json","w",encoding="utf-8") as f:
    json.dump(js,f,indent=2)

print("Report generated: simple_v2_analysis.md and simple_v2_analysis.json")
PY

echo -e "\n=== DONE ==="
echo "Files produced:"
ls -l "$BIN" "$OUT_RAW" "$OUT_GDB" "$OUT_MD" "$OUT_JSON" rodata.bin rodata_hexdump.txt || true

echo
echo "ISTRUZIONI:"
echo "1) Se lo esegui, prendi il file simple_v2_analysis.md e incollalo qui; io lo rifinisco in stile Presentation.txt (diagrammi, tabella byte-per-byte, pulizia)."
echo "2) Se vuoi che estenda l'analisi (es. dumping di tutti 100 slot di rubr_dyn con valore ascii, ricostruzione completa frame-by-frame), fammelo sapere e lo aggiungo."
