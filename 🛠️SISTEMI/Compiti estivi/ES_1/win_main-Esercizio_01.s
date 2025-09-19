	.file	"Esercizio_01.c"
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
.LC0:
	.ascii "w+\0"
.LC1:
	.ascii "ip_list.txt\0"
	.align 8
.LC2:
	.ascii "impossibile aprire il file '%s'\12\0"
.LC3:
	.ascii "fine\0"
	.align 8
.LC4:
	.ascii "Inserisci gli IP ('%s' x chiudere):\12\0"
.LC5:
	.ascii "> \0"
.LC6:
	.ascii "'%s' non \303\250 un Ip\12\0"
.LC7:
	.ascii "%s\12\0"
.LC8:
	.ascii "\12Indirizzi salvati su %s\12\12\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$144, %rsp
	.seh_stackalloc	144
	.seh_endprologue
	call	__main
	leaq	.LC0(%rip), %rdx
	leaq	.LC1(%rip), %rax
	movq	%rax, %rcx
	call	fopen
	movq	%rax, -8(%rbp)
	cmpq	$0, -8(%rbp)
	jne	.L29
	leaq	.LC1(%rip), %rdx
	leaq	.LC2(%rip), %rax
	movq	%rax, %rcx
	call	printf
	movl	$1, %eax
	jmp	.L39
.L29:
	leaq	.LC3(%rip), %rdx
	leaq	.LC4(%rip), %rax
	movq	%rax, %rcx
	call	printf
.L36:
	leaq	.LC5(%rip), %rax
	movq	%rax, %rcx
	call	printf
	movl	$0, %ecx
	movq	__imp___acrt_iob_func(%rip), %rax
	call	*%rax
	movq	%rax, %rdx
	leaq	-112(%rbp), %rax
	movq	%rdx, %r8
	movl	$100, %edx
	movq	%rax, %rcx
	call	fgets
	testq	%rax, %rax
	je	.L40
	leaq	-112(%rbp), %rax
	movq	%rax, %rcx
	call	noslashn
	leaq	-112(%rbp), %rax
	movq	%rax, %rcx
	call	strip
	leaq	.LC3(%rip), %rdx
	leaq	-112(%rbp), %rax
	movq	%rax, %rcx
	call	strcmp
	testl	%eax, %eax
	je	.L41
	leaq	-112(%rbp), %rax
	movq	%rax, %rcx
	call	isValidIp4
	testl	%eax, %eax
	jne	.L34
	leaq	-112(%rbp), %rax
	leaq	.LC6(%rip), %rcx
	movq	%rax, %rdx
	call	printf
	jmp	.L35
.L34:
	leaq	-112(%rbp), %rcx
	leaq	.LC7(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rcx, %r8
	movq	%rax, %rcx
	call	fprintf
	movq	-8(%rbp), %rax
	movq	%rax, %rcx
	call	fflush
.L35:
	jmp	.L36
.L40:
	nop
	jmp	.L32
.L41:
	nop
.L32:
	leaq	.LC1(%rip), %rdx
	leaq	.LC8(%rip), %rax
	movq	%rax, %rcx
	call	printf
	movq	-8(%rbp), %rax
	movq	%rax, %rcx
	call	rewind
	jmp	.L37
.L38:
	movl	$1, %ecx
	movq	__imp___acrt_iob_func(%rip), %rax
	call	*%rax
	movq	%rax, %rdx
	leaq	-112(%rbp), %rax
	movq	%rax, %rcx
	call	fputs
.L37:
	movq	-8(%rbp), %rdx
	leaq	-112(%rbp), %rax
	movq	%rdx, %r8
	movl	$100, %edx
	movq	%rax, %rcx
	call	fgets
	testq	%rax, %rax
	jne	.L38
	movq	-8(%rbp), %rax
	movq	%rax, %rcx
	call	fclose
	movl	$0, %eax
.L39:
	addq	$144, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (GNU) 15.1.0"
	.def	strchr;	.scl	2;	.type	32;	.endef
	.def	strlen;	.scl	2;	.type	32;	.endef
	.def	fopen;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	fgets;	.scl	2;	.type	32;	.endef
	.def	strcmp;	.scl	2;	.type	32;	.endef
	.def	fprintf;	.scl	2;	.type	32;	.endef
	.def	fflush;	.scl	2;	.type	32;	.endef
	.def	rewind;	.scl	2;	.type	32;	.endef
	.def	fputs;	.scl	2;	.type	32;	.endef
	.def	fclose;	.scl	2;	.type	32;	.endef
