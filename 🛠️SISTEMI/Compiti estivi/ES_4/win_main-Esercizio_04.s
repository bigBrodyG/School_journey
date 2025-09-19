	.file	"Esercizio_04.c"
	.text
	.section .rdata,"dr"
.LC0:
	.ascii "\12=== Questionario ===\0"
.LC1:
	.ascii "1) Aggiungi domanda\0"
.LC2:
	.ascii "2) Quiz\0"
.LC3:
	.ascii "3) Cancella domanda\0"
.LC4:
	.ascii "0) Esci\0"
.LC5:
	.ascii "Scelta: \0"
.LC6:
	.ascii "a\0"
.LC7:
	.ascii "questionario.txt\0"
.LC8:
	.ascii "errore file\0"
.LC9:
	.ascii "Domanda > \0"
.LC10:
	.ascii "A >\0"
.LC11:
	.ascii "B > \0"
.LC12:
	.ascii "C > \0"
.LC13:
	.ascii "D > \0"
.LC14:
	.ascii "\12\0"
.LC15:
	.ascii "Corretta (A,B,C,D): \0"
.LC16:
	.ascii " %c\0"
.LC17:
	.ascii "%s\12%s\12%s\12%s\12%s\12%c\12\12\0"
.LC18:
	.ascii "Aggiunta!\0"
.LC19:
	.ascii "r\0"
.LC20:
	.ascii "\12%d) %s\12\0"
.LC21:
	.ascii "A) %s\12B) %s\12C) %s\12D) %s\12\0"
.LC22:
	.ascii "Risposta: \0"
.LC23:
	.ascii "Risposta non valida\0"
.LC24:
	.ascii "Giusto!\0"
.LC25:
	.ascii "Sbagliato. Era %c\12\0"
.LC26:
	.ascii "\12Punteggio: %d/%d\12\0"
.LC27:
	.ascii "errore file o file vuoto\0"
.LC28:
	.ascii "\12=== Domande: ===\0"
.LC29:
	.ascii "%d) %s\12\0"
.LC30:
	.ascii "file voto\0"
	.align 8
.LC31:
	.ascii "\12 domanda da cancellare: (1-%d, 0 annulla)? \0"
.LC32:
	.ascii "Operazione annullata\0"
.LC33:
	.ascii "Numero non valido\0"
.LC34:
	.ascii "w\0"
	.align 8
.LC35:
	.ascii "errore nella riscrittura del file\0"
.LC36:
	.ascii "Domanda cancellata!\0"
.LC37:
	.ascii "Scelta non valida\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	pushq	%rbp
	.seh_pushreg	%rbp
	pushq	%rbx
	.seh_pushreg	%rbx
	movl	$517416, %eax
	call	___chkstk_ms
	subq	%rax, %rsp
	.seh_stackalloc	517416
	leaq	128(%rsp), %rbp
	.seh_setframe	%rbp, 128
	.seh_endprologue
	call	__main
.L38:
	leaq	.LC0(%rip), %rax
	movq	%rax, %rcx
	call	puts
	leaq	.LC1(%rip), %rax
	movq	%rax, %rcx
	call	puts
	leaq	.LC2(%rip), %rax
	movq	%rax, %rcx
	call	puts
	leaq	.LC3(%rip), %rax
	movq	%rax, %rcx
	call	puts
	leaq	.LC4(%rip), %rax
	movq	%rax, %rcx
	call	puts
	leaq	.LC5(%rip), %rax
	movq	%rax, %rcx
	call	printf
	movl	$0, %ecx
	movq	__imp___acrt_iob_func(%rip), %rax
	call	*%rax
	movq	%rax, %rdx
	leaq	-64(%rbp), %rax
	movq	%rdx, %r8
	movl	$32, %edx
	movq	%rax, %rcx
	call	fgets
	leaq	-64(%rbp), %rax
	movq	%rax, %rcx
	call	atoi
	movl	%eax, 517260(%rbp)
	cmpl	$0, 517260(%rbp)
	jne	.L2
	movl	$0, %eax
	jmp	.L37
.L2:
	cmpl	$1, 517260(%rbp)
	jne	.L4
	leaq	.LC6(%rip), %rdx
	leaq	.LC7(%rip), %rax
	movq	%rax, %rcx
	call	fopen
	movq	%rax, 517216(%rbp)
	cmpq	$0, 517216(%rbp)
	jne	.L5
	leaq	.LC8(%rip), %rax
	movq	%rax, %rcx
	call	puts
	jmp	.L38
.L5:
	leaq	.LC9(%rip), %rax
	movq	%rax, %rcx
	call	printf
	movl	$0, %ecx
	movq	__imp___acrt_iob_func(%rip), %rax
	call	*%rax
	movq	%rax, %rdx
	leaq	5200(%rbp), %rax
	movq	%rdx, %r8
	movl	$1024, %edx
	movq	%rax, %rcx
	call	fgets
	leaq	.LC10(%rip), %rax
	movq	%rax, %rcx
	call	printf
	movl	$0, %ecx
	movq	__imp___acrt_iob_func(%rip), %rax
	call	*%rax
	movq	%rax, %rdx
	leaq	107600(%rbp), %rax
	movq	%rdx, %r8
	movl	$1024, %edx
	movq	%rax, %rcx
	call	fgets
	leaq	.LC11(%rip), %rax
	movq	%rax, %rcx
	call	printf
	movl	$0, %ecx
	movq	__imp___acrt_iob_func(%rip), %rax
	call	*%rax
	movq	%rax, %rdx
	leaq	210000(%rbp), %rax
	movq	%rdx, %r8
	movl	$1024, %edx
	movq	%rax, %rcx
	call	fgets
	leaq	.LC12(%rip), %rax
	movq	%rax, %rcx
	call	printf
	movl	$0, %ecx
	movq	__imp___acrt_iob_func(%rip), %rax
	call	*%rax
	movq	%rax, %rdx
	leaq	312400(%rbp), %rax
	movq	%rdx, %r8
	movl	$1024, %edx
	movq	%rax, %rcx
	call	fgets
	leaq	.LC13(%rip), %rax
	movq	%rax, %rcx
	call	printf
	movl	$0, %ecx
	movq	__imp___acrt_iob_func(%rip), %rax
	call	*%rax
	movq	%rax, %rdx
	leaq	414800(%rbp), %rax
	movq	%rdx, %r8
	movl	$1024, %edx
	movq	%rax, %rcx
	call	fgets
	leaq	.LC14(%rip), %rdx
	leaq	5200(%rbp), %rax
	movq	%rax, %rcx
	call	strcspn
	movb	$0, 5200(%rbp,%rax)
	leaq	.LC14(%rip), %rdx
	leaq	107600(%rbp), %rax
	movq	%rax, %rcx
	call	strcspn
	movb	$0, 107600(%rbp,%rax)
	leaq	.LC14(%rip), %rdx
	leaq	210000(%rbp), %rax
	movq	%rax, %rcx
	call	strcspn
	movb	$0, 210000(%rbp,%rax)
	leaq	.LC14(%rip), %rdx
	leaq	312400(%rbp), %rax
	movq	%rax, %rcx
	call	strcspn
	movb	$0, 312400(%rbp,%rax)
	leaq	.LC14(%rip), %rdx
	leaq	414800(%rbp), %rax
	movq	%rax, %rcx
	call	strcspn
	movb	$0, 414800(%rbp,%rax)
	movb	$90, 517215(%rbp)
	jmp	.L7
.L8:
	leaq	.LC15(%rip), %rax
	movq	%rax, %rcx
	call	printf
	leaq	517215(%rbp), %rax
	leaq	.LC16(%rip), %rcx
	movq	%rax, %rdx
	call	scanf
	movzbl	517215(%rbp), %eax
	movsbl	%al, %eax
	movl	%eax, %ecx
	movq	__imp_toupper(%rip), %rax
	call	*%rax
	movb	%al, 517215(%rbp)
.L7:
	movzbl	517215(%rbp), %eax
	cmpb	$64, %al
	jle	.L8
	movzbl	517215(%rbp), %eax
	cmpb	$68, %al
	jg	.L8
	movl	$0, %ecx
	movq	__imp___acrt_iob_func(%rip), %rax
	call	*%rax
	movq	%rax, %rdx
	leaq	-64(%rbp), %rax
	movq	%rdx, %r8
	movl	$32, %edx
	movq	%rax, %rcx
	call	fgets
	movzbl	517215(%rbp), %eax
	movsbl	%al, %ecx
	leaq	107600(%rbp), %r9
	leaq	5200(%rbp), %r8
	leaq	.LC17(%rip), %rdx
	movq	517216(%rbp), %rax
	movl	%ecx, 56(%rsp)
	leaq	414800(%rbp), %rcx
	movq	%rcx, 48(%rsp)
	leaq	312400(%rbp), %rcx
	movq	%rcx, 40(%rsp)
	leaq	210000(%rbp), %rcx
	movq	%rcx, 32(%rsp)
	movq	%rax, %rcx
	call	fprintf
	movq	517216(%rbp), %rax
	movq	%rax, %rcx
	call	fclose
	leaq	.LC18(%rip), %rax
	movq	%rax, %rcx
	call	puts
	jmp	.L38
.L4:
	cmpl	$2, 517260(%rbp)
	jne	.L10
	leaq	.LC19(%rip), %rdx
	leaq	.LC7(%rip), %rax
	movq	%rax, %rcx
	call	fopen
	movq	%rax, 517232(%rbp)
	cmpq	$0, 517232(%rbp)
	jne	.L11
	leaq	.LC8(%rip), %rax
	movq	%rax, %rcx
	call	puts
	movl	$1, %eax
	jmp	.L37
.L11:
	movl	$0, 517276(%rbp)
	movl	$0, 517272(%rbp)
	jmp	.L12
.L20:
	leaq	5200(%rbp), %rax
	movq	%rax, %rcx
	call	strlen
	cmpq	$1, %rax
	jbe	.L39
	leaq	.LC14(%rip), %rdx
	leaq	5200(%rbp), %rax
	movq	%rax, %rcx
	call	strcspn
	movb	$0, 5200(%rbp,%rax)
	movq	517232(%rbp), %rdx
	leaq	107600(%rbp), %rax
	movq	%rdx, %r8
	movl	$1024, %edx
	movq	%rax, %rcx
	call	fgets
	movq	517232(%rbp), %rdx
	leaq	210000(%rbp), %rax
	movq	%rdx, %r8
	movl	$1024, %edx
	movq	%rax, %rcx
	call	fgets
	movq	517232(%rbp), %rdx
	leaq	312400(%rbp), %rax
	movq	%rdx, %r8
	movl	$1024, %edx
	movq	%rax, %rcx
	call	fgets
	movq	517232(%rbp), %rdx
	leaq	414800(%rbp), %rax
	movq	%rdx, %r8
	movl	$1024, %edx
	movq	%rax, %rcx
	call	fgets
	leaq	517214(%rbp), %rcx
	leaq	.LC16(%rip), %rdx
	movq	517232(%rbp), %rax
	movq	%rcx, %r8
	movq	%rax, %rcx
	call	fscanf
	leaq	.LC14(%rip), %rdx
	leaq	107600(%rbp), %rax
	movq	%rax, %rcx
	call	strcspn
	movb	$0, 107600(%rbp,%rax)
	leaq	.LC14(%rip), %rdx
	leaq	210000(%rbp), %rax
	movq	%rax, %rcx
	call	strcspn
	movb	$0, 210000(%rbp,%rax)
	leaq	.LC14(%rip), %rdx
	leaq	312400(%rbp), %rax
	movq	%rax, %rcx
	call	strcspn
	movb	$0, 312400(%rbp,%rax)
	leaq	.LC14(%rip), %rdx
	leaq	414800(%rbp), %rax
	movq	%rax, %rcx
	call	strcspn
	movb	$0, 414800(%rbp,%rax)
	addl	$1, 517276(%rbp)
	leaq	5200(%rbp), %rdx
	movl	517276(%rbp), %eax
	leaq	.LC20(%rip), %rcx
	movq	%rdx, %r8
	movl	%eax, %edx
	call	printf
	leaq	312400(%rbp), %r9
	leaq	210000(%rbp), %r8
	leaq	107600(%rbp), %rax
	leaq	.LC21(%rip), %rcx
	leaq	414800(%rbp), %rdx
	movq	%rdx, 32(%rsp)
	movq	%rax, %rdx
	call	printf
	leaq	.LC22(%rip), %rax
	movq	%rax, %rcx
	call	printf
	leaq	517213(%rbp), %rax
	leaq	.LC16(%rip), %rcx
	movq	%rax, %rdx
	call	scanf
	movzbl	517213(%rbp), %eax
	movsbl	%al, %eax
	movl	%eax, %ecx
	movq	__imp_toupper(%rip), %rax
	call	*%rax
	movb	%al, 517213(%rbp)
	movzbl	517214(%rbp), %eax
	movsbl	%al, %eax
	subl	$65, %eax
	movl	%eax, 517228(%rbp)
	movzbl	517213(%rbp), %eax
	movsbl	%al, %eax
	subl	$65, %eax
	movl	%eax, 517224(%rbp)
	cmpl	$0, 517224(%rbp)
	js	.L15
	cmpl	$3, 517224(%rbp)
	jle	.L16
.L15:
	leaq	.LC23(%rip), %rax
	movq	%rax, %rcx
	call	puts
	jmp	.L12
.L16:
	movl	517228(%rbp), %eax
	cmpl	517224(%rbp), %eax
	jne	.L17
	leaq	.LC24(%rip), %rax
	movq	%rax, %rcx
	call	puts
	addl	$1, 517272(%rbp)
	jmp	.L18
.L17:
	movzbl	517214(%rbp), %eax
	movsbl	%al, %eax
	leaq	.LC25(%rip), %rcx
	movl	%eax, %edx
	call	printf
.L18:
	movq	517232(%rbp), %rdx
	leaq	-64(%rbp), %rax
	movq	%rdx, %r8
	movl	$32, %edx
	movq	%rax, %rcx
	call	fgets
	jmp	.L12
.L39:
	nop
.L12:
	movq	517232(%rbp), %rdx
	leaq	5200(%rbp), %rax
	movq	%rdx, %r8
	movl	$1024, %edx
	movq	%rax, %rcx
	call	fgets
	testq	%rax, %rax
	jne	.L20
	movq	517232(%rbp), %rax
	movq	%rax, %rcx
	call	fclose
	movl	517276(%rbp), %edx
	movl	517272(%rbp), %eax
	leaq	.LC26(%rip), %rcx
	movl	%edx, %r8d
	movl	%eax, %edx
	call	printf
	jmp	.L38
.L10:
	cmpl	$3, 517260(%rbp)
	jne	.L21
	leaq	.LC19(%rip), %rdx
	leaq	.LC7(%rip), %rax
	movq	%rax, %rcx
	call	fopen
	movq	%rax, 517248(%rbp)
	cmpq	$0, 517248(%rbp)
	jne	.L22
	leaq	.LC27(%rip), %rax
	movq	%rax, %rcx
	call	puts
	jmp	.L36
.L22:
	movl	$0, 517268(%rbp)
	leaq	.LC28(%rip), %rax
	movq	%rax, %rcx
	call	puts
	jmp	.L24
.L27:
	leaq	80(%rbp), %rax
	movq	%rax, %rcx
	call	strlen
	cmpq	$1, %rax
	jbe	.L40
	leaq	.LC14(%rip), %rdx
	leaq	80(%rbp), %rax
	movq	%rax, %rcx
	call	strcspn
	movb	$0, 80(%rbp,%rax)
	movq	517248(%rbp), %rdx
	leaq	1104(%rbp), %rax
	movq	%rdx, %r8
	movl	$1024, %edx
	movq	%rax, %rcx
	call	fgets
	movq	517248(%rbp), %rdx
	leaq	2128(%rbp), %rax
	movq	%rdx, %r8
	movl	$1024, %edx
	movq	%rax, %rcx
	call	fgets
	movq	517248(%rbp), %rdx
	leaq	3152(%rbp), %rax
	movq	%rdx, %r8
	movl	$1024, %edx
	movq	%rax, %rcx
	call	fgets
	movq	517248(%rbp), %rdx
	leaq	4176(%rbp), %rax
	movq	%rdx, %r8
	movl	$1024, %edx
	movq	%rax, %rcx
	call	fgets
	leaq	517212(%rbp), %rcx
	leaq	.LC16(%rip), %rdx
	movq	517248(%rbp), %rax
	movq	%rcx, %r8
	movq	%rax, %rcx
	call	fscanf
	leaq	.LC14(%rip), %rdx
	leaq	1104(%rbp), %rax
	movq	%rax, %rcx
	call	strcspn
	movb	$0, 1104(%rbp,%rax)
	leaq	.LC14(%rip), %rdx
	leaq	2128(%rbp), %rax
	movq	%rax, %rcx
	call	strcspn
	movb	$0, 2128(%rbp,%rax)
	leaq	.LC14(%rip), %rdx
	leaq	3152(%rbp), %rax
	movq	%rax, %rcx
	call	strcspn
	movb	$0, 3152(%rbp,%rax)
	leaq	.LC14(%rip), %rdx
	leaq	4176(%rbp), %rax
	movq	%rax, %rcx
	call	strcspn
	movb	$0, 4176(%rbp,%rax)
	leaq	5200(%rbp), %rax
	movl	517268(%rbp), %edx
	movslq	%edx, %rdx
	salq	$10, %rdx
	leaq	(%rax,%rdx), %rcx
	leaq	80(%rbp), %rax
	movq	%rax, %rdx
	call	strcpy
	leaq	107600(%rbp), %rax
	movl	517268(%rbp), %edx
	movslq	%edx, %rdx
	salq	$10, %rdx
	leaq	(%rax,%rdx), %rcx
	leaq	1104(%rbp), %rax
	movq	%rax, %rdx
	call	strcpy
	leaq	210000(%rbp), %rax
	movl	517268(%rbp), %edx
	movslq	%edx, %rdx
	salq	$10, %rdx
	leaq	(%rax,%rdx), %rcx
	leaq	2128(%rbp), %rax
	movq	%rax, %rdx
	call	strcpy
	leaq	312400(%rbp), %rax
	movl	517268(%rbp), %edx
	movslq	%edx, %rdx
	salq	$10, %rdx
	leaq	(%rax,%rdx), %rcx
	leaq	3152(%rbp), %rax
	movq	%rax, %rdx
	call	strcpy
	leaq	414800(%rbp), %rax
	movl	517268(%rbp), %edx
	movslq	%edx, %rdx
	salq	$10, %rdx
	leaq	(%rax,%rdx), %rcx
	leaq	4176(%rbp), %rax
	movq	%rax, %rdx
	call	strcpy
	movzbl	517212(%rbp), %edx
	movl	517268(%rbp), %eax
	cltq
	movb	%dl, -32(%rbp,%rax)
	movl	517268(%rbp), %eax
	leal	1(%rax), %edx
	leaq	80(%rbp), %rcx
	leaq	.LC29(%rip), %rax
	movq	%rcx, %r8
	movq	%rax, %rcx
	call	printf
	addl	$1, 517268(%rbp)
	movq	517248(%rbp), %rdx
	leaq	-64(%rbp), %rax
	movq	%rdx, %r8
	movl	$32, %edx
	movq	%rax, %rcx
	call	fgets
	jmp	.L24
.L40:
	nop
.L24:
	movq	517248(%rbp), %rdx
	leaq	80(%rbp), %rax
	movq	%rdx, %r8
	movl	$1024, %edx
	movq	%rax, %rcx
	call	fgets
	testq	%rax, %rax
	jne	.L27
	movq	517248(%rbp), %rax
	movq	%rax, %rcx
	call	fclose
	cmpl	$0, 517268(%rbp)
	jne	.L28
	leaq	.LC30(%rip), %rax
	movq	%rax, %rcx
	call	puts
	jmp	.L36
.L28:
	movl	517268(%rbp), %eax
	leaq	.LC31(%rip), %rcx
	movl	%eax, %edx
	call	printf
	movl	$0, %ecx
	movq	__imp___acrt_iob_func(%rip), %rax
	call	*%rax
	movq	%rax, %rdx
	leaq	-64(%rbp), %rax
	movq	%rdx, %r8
	movl	$32, %edx
	movq	%rax, %rcx
	call	fgets
	leaq	-64(%rbp), %rax
	movq	%rax, %rcx
	call	atoi
	movl	%eax, 517244(%rbp)
	cmpl	$0, 517244(%rbp)
	jne	.L29
	leaq	.LC32(%rip), %rax
	movq	%rax, %rcx
	call	puts
	jmp	.L36
.L29:
	cmpl	$0, 517244(%rbp)
	jle	.L30
	movl	517244(%rbp), %eax
	cmpl	517268(%rbp), %eax
	jle	.L31
.L30:
	leaq	.LC33(%rip), %rax
	movq	%rax, %rcx
	call	puts
	jmp	.L36
.L31:
	leaq	.LC34(%rip), %rdx
	leaq	.LC7(%rip), %rax
	movq	%rax, %rcx
	call	fopen
	movq	%rax, 517248(%rbp)
	cmpq	$0, 517248(%rbp)
	jne	.L32
	leaq	.LC35(%rip), %rax
	movq	%rax, %rcx
	call	puts
	jmp	.L36
.L32:
	movl	$0, 517264(%rbp)
	jmp	.L33
.L35:
	movl	517244(%rbp), %eax
	subl	$1, %eax
	cmpl	%eax, 517264(%rbp)
	je	.L34
	movl	517264(%rbp), %eax
	cltq
	movzbl	-32(%rbp,%rax), %eax
	movsbl	%al, %ecx
	leaq	414800(%rbp), %rax
	movl	517264(%rbp), %edx
	movslq	%edx, %rdx
	salq	$10, %rdx
	leaq	(%rax,%rdx), %r10
	leaq	312400(%rbp), %rax
	movl	517264(%rbp), %edx
	movslq	%edx, %rdx
	salq	$10, %rdx
	leaq	(%rax,%rdx), %r9
	leaq	210000(%rbp), %rax
	movl	517264(%rbp), %edx
	movslq	%edx, %rdx
	salq	$10, %rdx
	leaq	(%rax,%rdx), %r8
	leaq	107600(%rbp), %rax
	movl	517264(%rbp), %edx
	movslq	%edx, %rdx
	salq	$10, %rdx
	leaq	(%rax,%rdx), %rbx
	leaq	5200(%rbp), %rax
	movl	517264(%rbp), %edx
	movslq	%edx, %rdx
	salq	$10, %rdx
	leaq	(%rax,%rdx), %r11
	leaq	.LC17(%rip), %rdx
	movq	517248(%rbp), %rax
	movl	%ecx, 56(%rsp)
	movq	%r10, 48(%rsp)
	movq	%r9, 40(%rsp)
	movq	%r8, 32(%rsp)
	movq	%rbx, %r9
	movq	%r11, %r8
	movq	%rax, %rcx
	call	fprintf
.L34:
	addl	$1, 517264(%rbp)
.L33:
	movl	517264(%rbp), %eax
	cmpl	517268(%rbp), %eax
	jl	.L35
	movq	517248(%rbp), %rax
	movq	%rax, %rcx
	call	fclose
	leaq	.LC36(%rip), %rax
	movq	%rax, %rcx
	call	puts
	jmp	.L38
.L21:
	leaq	.LC37(%rip), %rax
	movq	%rax, %rcx
	call	puts
.L36:
	jmp	.L38
.L37:
	addq	$517416, %rsp
	popq	%rbx
	popq	%rbp
	ret
	.seh_endproc
	.def	__main;	.scl	2;	.type	32;	.endef
	.ident	"GCC: (GNU) 15.1.0"
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
	.def	fgets;	.scl	2;	.type	32;	.endef
	.def	atoi;	.scl	2;	.type	32;	.endef
	.def	fopen;	.scl	2;	.type	32;	.endef
	.def	strcspn;	.scl	2;	.type	32;	.endef
	.def	scanf;	.scl	2;	.type	32;	.endef
	.def	fprintf;	.scl	2;	.type	32;	.endef
	.def	fclose;	.scl	2;	.type	32;	.endef
	.def	strlen;	.scl	2;	.type	32;	.endef
	.def	fscanf;	.scl	2;	.type	32;	.endef
	.def	strcpy;	.scl	2;	.type	32;	.endef
