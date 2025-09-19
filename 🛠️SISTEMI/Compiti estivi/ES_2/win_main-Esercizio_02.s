	.file	"Esercizio_02.c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "r\0"
.LC1:
	.ascii "mac_list.txt\0"
.LC2:
	.ascii "errore file\0"
.LC3:
	.ascii "\12%d MAC in tutto\12\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbp
	.seh_pushreg	%rbp
	movq	%rsp, %rbp
	.seh_setframe	%rbp, 0
	subq	$112, %rsp
	.seh_stackalloc	112
	.seh_endprologue
	call	__main
	leaq	.LC0(%rip), %rdx
	leaq	.LC1(%rip), %rax
	movq	%rax, %rcx
	call	fopen
	movq	%rax, -16(%rbp)
	cmpq	$0, -16(%rbp)
	jne	.L2
	leaq	.LC2(%rip), %rax
	movq	%rax, %rcx
	call	printf
	movl	$1, %eax
	jmp	.L12
.L2:
	movl	$0, -4(%rbp)
	jmp	.L4
.L11:
	movl	$0, -8(%rbp)
	jmp	.L5
.L8:
	movl	-8(%rbp), %eax
	cltq
	movzbl	-80(%rbp,%rax), %eax
	cmpb	$10, %al
	jne	.L6
	movl	-8(%rbp), %eax
	cltq
	movb	$0, -80(%rbp,%rax)
	jmp	.L7
.L6:
	addl	$1, -8(%rbp)
.L5:
	movl	-8(%rbp), %eax
	cltq
	movzbl	-80(%rbp,%rax), %eax
	testb	%al, %al
	jne	.L8
.L7:
	movzbl	-80(%rbp), %eax
	testb	%al, %al
	je	.L13
	leaq	-80(%rbp), %rax
	movq	%rax, %rcx
	call	puts
	addl	$1, -4(%rbp)
	jmp	.L4
.L13:
	nop
.L4:
	movq	-16(%rbp), %rdx
	leaq	-80(%rbp), %rax
	movq	%rdx, %r8
	movl	$64, %edx
	movq	%rax, %rcx
	call	fgets
	testq	%rax, %rax
	jne	.L11
	movl	-4(%rbp), %eax
	leaq	.LC3(%rip), %rcx
	movl	%eax, %edx
	call	printf
	movq	-16(%rbp), %rax
	movq	%rax, %rcx
	call	fclose
	movl	$0, %eax
.L12:
	addq	$112, %rsp
	popq	%rbp
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (GNU) 15.1.0"
	.def	fopen;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	fgets;	.scl	2;	.type	32;	.endef
	.def	fclose;	.scl	2;	.type	32;	.endef
