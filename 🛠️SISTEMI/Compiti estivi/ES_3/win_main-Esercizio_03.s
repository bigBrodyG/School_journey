	.file	"Esercizio_03.c"
	.text
	.globl	noslashn
	.def	noslashn;	.scl	2;	.type	32;	.endef
	.seh_proc	noslashn
noslashn:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$48, %rsp
	.seh_stackalloc	48
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	movq	16(%rbp), %rax
	movl	$10, %edx
	movq	%rax, %rcx
	call	strchr
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)
	je	.L3
	movq	-8(%rbp), %rax
	movb	$0, (%rax)
.L3:
	nop
	addq	$48, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	strip
	.def	strip;	.scl	2;	.type	32;	.endef
	.seh_proc	strip
strip:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$64, %rsp
	.seh_stackalloc	64
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	movq	16(%rbp), %rax
	movq	%rax, -8(%rbp)
	jmp	.L5
.L7:
	addq	$1, -8(%rbp)
.L5:
	movq	-8(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	je	.L6
	movq	-8(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$32, %al
	je	.L7
.L6:
	movq	-8(%rbp), %rax
	cmpq	16(%rbp), %rax
	je	.L8
	movq	16(%rbp), %rax
	movq	%rax, -16(%rbp)
	jmp	.L9
.L10:
	movq	-8(%rbp), %rdx
	leaq	1(%rdx), %rax
	movq	%rax, -8(%rbp)
	movq	-16(%rbp), %rax
	leaq	1(%rax), %rcx
	movq	%rcx, -16(%rbp)
	movzbl	(%rdx), %edx
	movb	%dl, (%rax)
.L9:
	movq	-8(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L10
	movq	-16(%rbp), %rax
	movb	$0, (%rax)
.L8:
	movq	16(%rbp), %rax
	movq	%rax, %rcx
	call	strlen
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	je	.L15
	movq	-32(%rbp), %rax
	leaq	-1(%rax), %rdx
	movq	16(%rbp), %rax
	addq	%rdx, %rax
	movq	%rax, -24(%rbp)
	jmp	.L13
.L14:
	movq	-24(%rbp), %rax
	movb	$0, (%rax)
	subq	$1, -24(%rbp)
.L13:
	movq	-24(%rbp), %rax
	cmpq	16(%rbp), %rax
	jb	.L4
	movq	-24(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$32, %al
	je	.L14
	jmp	.L4
.L15:
	nop
.L4:
	addq	$64, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.globl	isValidIp4
	.def	isValidIp4;	.scl	2;	.type	32;	.endef
	.seh_proc	isValidIp4
isValidIp4:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$16, %rsp
	.seh_stackalloc	16
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	movq	16(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L17
	movl	$0, %eax
	jmp	.L18
.L17:
	movl	$0, -4(%rbp)
	jmp	.L19
.L27:
	movl	$0, -8(%rbp)
	movl	$0, -12(%rbp)
	jmp	.L20
.L23:
	movl	-8(%rbp), %edx
	movl	%edx, %eax
	sall	$2, %eax
	addl	%edx, %eax
	addl	%eax, %eax
	movl	%eax, %edx
	movq	16(%rbp), %rax
	movzbl	(%rax), %eax
	movsbl	%al, %eax
	subl	$48, %eax
	addl	%edx, %eax
	movl	%eax, -8(%rbp)
	cmpl	$255, -8(%rbp)
	jle	.L21
	movl	$0, %eax
	jmp	.L18
.L21:
	addq	$1, 16(%rbp)
	addl	$1, -12(%rbp)
.L20:
	movq	16(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$47, %al
	jle	.L22
	movq	16(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$57, %al
	jle	.L23
.L22:
	cmpl	$0, -12(%rbp)
	jne	.L24
	movl	$0, %eax
	jmp	.L18
.L24:
	addl	$1, -4(%rbp)
	cmpl	$4, -4(%rbp)
	jne	.L25
	movq	16(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	sete	%al
	movzbl	%al, %eax
	jmp	.L18
.L25:
	movq	16(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$46, %al
	je	.L26
	movl	$0, %eax
	jmp	.L18
.L26:
	addq	$1, 16(%rbp)
.L19:
	movq	16(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L27
	movl	$0, %eax
.L18:
	addq	$16, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
	.align 8
.LC0:
	.ascii "%2hhx:%2hhx:%2hhx:%2hhx:%2hhx:%2hhx%n\0"
	.text
	.globl	isValidMac
	.def	isValidMac;	.scl	2;	.type	32;	.endef
	.seh_proc	isValidMac
isValidMac:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$96, %rsp
	.seh_stackalloc	96
	.seh_endprologue
	movq	%rcx, 16(%rbp)
	cmpq	$0, 16(%rbp)
	jne	.L29
	movl	$0, %eax
	jmp	.L33
.L29:
	movl	$0, -16(%rbp)
	leaq	-10(%rbp), %rax
	leaq	1(%rax), %r9
	leaq	-10(%rbp), %r8
	leaq	.LC0(%rip), %rdx
	movq	16(%rbp), %rax
	leaq	-16(%rbp), %rcx
	movq	%rcx, 64(%rsp)
	leaq	-10(%rbp), %rcx
	addq	$5, %rcx
	movq	%rcx, 56(%rsp)
	leaq	-10(%rbp), %rcx
	addq	$4, %rcx
	movq	%rcx, 48(%rsp)
	leaq	-10(%rbp), %rcx
	addq	$3, %rcx
	movq	%rcx, 40(%rsp)
	leaq	-10(%rbp), %rcx
	addq	$2, %rcx
	movq	%rcx, 32(%rsp)
	movq	%rax, %rcx
	call	sscanf
	movl	%eax, -4(%rbp)
	cmpl	$6, -4(%rbp)
	jne	.L31
	movl	-16(%rbp), %eax
	movslq	%eax, %rdx
	movq	16(%rbp), %rax
	addq	%rdx, %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	je	.L32
.L31:
	movl	$0, %eax
	jmp	.L33
.L32:
	movl	$1, %eax
.L33:
	addq	$96, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.section .rdata,"dr"
.LC1:
	.ascii "a+\0"
.LC2:
	.ascii "arp_table.txt\0"
	.align 8
.LC3:
	.ascii "impossibile aprire il file '%s'\12\0"
.LC4:
	.ascii "fine\0"
	.align 8
.LC5:
	.ascii "Arp table. Inserisci ip e mac. '%s' x chiudere:\12\0"
.LC6:
	.ascii "> \0"
.LC7:
	.ascii "solo uno spazio tra IP e MAC\0"
.LC8:
	.ascii "'%s' non \303\250 un IP\12\0"
.LC9:
	.ascii "'%s' non \303\250 un MAC\12\0"
.LC10:
	.ascii "%s %s\12\0"
.LC11:
	.ascii "\12arp table salvata su %s\12\12\0"
.LC12:
	.ascii "r\0"
.LC13:
	.ascii "errore file '%s'\12\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$176, %rsp
	.seh_stackalloc	176
	.seh_endprologue
	call	__main
	leaq	.LC1(%rip), %rdx
	leaq	.LC2(%rip), %rax
	movq	%rax, %rcx
	call	fopen
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	jne	.L35
	leaq	.LC2(%rip), %rdx
	leaq	.LC3(%rip), %rax
	movq	%rax, %rcx
	call	printf
	movl	$1, %eax
	jmp	.L55
.L35:
	leaq	.LC4(%rip), %rdx
	leaq	.LC5(%rip), %rax
	movq	%rax, %rcx
	call	printf
.L51:
	leaq	.LC6(%rip), %rax
	movq	%rax, %rcx
	call	printf
	movl	$0, %ecx
	movq	__imp___acrt_iob_func(%rip), %rax
	call	*%rax
	movq	%rax, %rdx
	leaq	-144(%rbp), %rax
	movq	%rdx, %r8
	movl	$100, %edx
	movq	%rax, %rcx
	call	fgets
	testq	%rax, %rax
	je	.L56
	leaq	-144(%rbp), %rax
	movq	%rax, %rcx
	call	noslashn
	leaq	-144(%rbp), %rax
	movq	%rax, %rcx
	call	strip
	leaq	.LC4(%rip), %rdx
	leaq	-144(%rbp), %rax
	movq	%rax, %rcx
	call	strcmp
	testl	%eax, %eax
	je	.L57
	leaq	-144(%rbp), %rax
	movq	%rax, -32(%rbp)
	movq	$0, -8(%rbp)
	leaq	-144(%rbp), %rax
	movq	%rax, -16(%rbp)
	jmp	.L40
.L45:
	movq	-16(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$32, %al
	jne	.L41
	movq	-16(%rbp), %rax
	movb	$0, (%rax)
	movq	-16(%rbp), %rax
	addq	$1, %rax
	movq	%rax, -8(%rbp)
	jmp	.L42
.L43:
	addq	$1, -8(%rbp)
.L42:
	movq	-8(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	$32, %al
	je	.L43
	jmp	.L44
.L41:
	addq	$1, -16(%rbp)
.L40:
	movq	-16(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L45
.L44:
	cmpq	$0, -8(%rbp)
	je	.L46
	movq	-8(%rbp), %rax
	movzbl	(%rax), %eax
	testb	%al, %al
	jne	.L47
.L46:
	leaq	.LC7(%rip), %rax
	movq	%rax, %rcx
	call	puts
	jmp	.L48
.L47:
	movq	-32(%rbp), %rax
	movq	%rax, %rcx
	call	isValidIp4
	testl	%eax, %eax
	jne	.L49
	movq	-32(%rbp), %rax
	leaq	.LC8(%rip), %rcx
	movq	%rax, %rdx
	call	printf
	jmp	.L48
.L49:
	movq	-8(%rbp), %rax
	movq	%rax, %rcx
	call	isValidMac
	testl	%eax, %eax
	jne	.L50
	movq	-8(%rbp), %rax
	leaq	.LC9(%rip), %rcx
	movq	%rax, %rdx
	call	printf
	jmp	.L48
.L50:
	movq	-8(%rbp), %r8
	movq	-32(%rbp), %rcx
	leaq	.LC10(%rip), %rdx
	movq	-24(%rbp), %rax
	movq	%r8, %r9
	movq	%rcx, %r8
	movq	%rax, %rcx
	call	fprintf
	movq	-24(%rbp), %rax
	movq	%rax, %rcx
	call	fflush
.L48:
	jmp	.L51
.L56:
	nop
	jmp	.L38
.L57:
	nop
.L38:
	leaq	.LC2(%rip), %rdx
	leaq	.LC11(%rip), %rax
	movq	%rax, %rcx
	call	printf
	movq	-24(%rbp), %rax
	movq	%rax, %rcx
	call	fclose
	leaq	.LC12(%rip), %rdx
	leaq	.LC2(%rip), %rax
	movq	%rax, %rcx
	call	fopen
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	jne	.L53
	leaq	.LC2(%rip), %rdx
	leaq	.LC13(%rip), %rax
	movq	%rax, %rcx
	call	printf
	movl	$1, %eax
	jmp	.L55
.L54:
	movl	$1, %ecx
	movq	__imp___acrt_iob_func(%rip), %rax
	call	*%rax
	movq	%rax, %rdx
	leaq	-144(%rbp), %rax
	movq	%rax, %rcx
	call	fputs
.L53:
	movq	-24(%rbp), %rdx
	leaq	-144(%rbp), %rax
	movq	%rdx, %r8
	movl	$100, %edx
	movq	%rax, %rcx
	call	fgets
	testq	%rax, %rax
	jne	.L54
	movq	-24(%rbp), %rax
	movq	%rax, %rcx
	call	fclose
	movl	$0, %eax
.L55:
	addq	$176, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (GNU) 15.1.0"
	.def	strchr;	.scl	2;	.type	32;	.endef
	.def	strlen;	.scl	2;	.type	32;	.endef
	.def	sscanf;	.scl	2;	.type	32;	.endef
	.def	fopen;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	fgets;	.scl	2;	.type	32;	.endef
	.def	strcmp;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	fprintf;	.scl	2;	.type	32;	.endef
	.def	fflush;	.scl	2;	.type	32;	.endef
	.def	fclose;	.scl	2;	.type	32;	.endef
	.def	fputs;	.scl	2;	.type	32;	.endef
