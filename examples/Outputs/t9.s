	.file	"t9.p"
.section	.rodata
.LLC0:
	.string "%d"
.LLC1:
	.string "%d\n"
.LLD0:
	.string "%f"
.LLD1:
	.string "%f\n"
.section	".text"
	.globl factorial
	.type	factorial,@function
factorial:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$40, %esp
	pushl	%ebx
	pushl	%esi
	pushl	%edi
	movl %ecx, -8(%ebp)
	movl	%ebp, %ecx
	movl	8(%ecx), %ebx
	cmpl $1, %ebx
	jle .LLt2
	movl $0, %ebx
	jmp .LLf2
.LLt2:	movl $1, %ebx
.LLf2:
	cmpl	$0, %ebx
	jne	.LL1
	movl	%ebp, %ecx
	movl	8(%ecx), %ebx
	movl	%ebp, %ecx
	movl	8(%ecx), %esi
	subl	$1, %esi
	pushl	%esi
#caller is not parent
	movl	-8(%ebp), %ecx
	call	factorial
	addl	$4, %esp
	movl	%eax, %esi
	imull	%esi, %ebx
	movl	%ebx, -4(%ebp)
	jmp	.LL0
.LL1:
	movl	$1, %ebx
	movl	%ebx, -4(%ebp)
.LL0:
.LL3:
	movl -4(%ebp),%eax
	popl	%edi
	popl	%esi
	popl	%ebx
	addl	$40, %esp
	leave
	ret
.LLfe3:
	.size	factorial, .LLfe3-factorial
	.globl main
	.type	main,@function
main:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$8, %esp
	andl	$-16, %esp
	movl	$0, %eax
	subl	%eax, %esp
	call	boo
	leave
	ret
.LLfe4:
	.size	main, .LLfe4-main
	.globl boo
	.type	boo,@function
boo:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$48, %esp
	pushl	%ebx
	pushl	%esi
	pushl	%edi
	movl %ecx, -8(%ebp)
	movl	%ebp, %ecx
	subl	$8, %esp
	leal	-40(%ecx), %eax
	pushl	%eax
	pushl	$.LLC0
	call	scanf
	addl	$16, %esp
	movl	%ebp, %ecx
	movl	-40(%ecx), %ebx
	pushl	%ebx
#caller is not parent
	movl	-8(%ebp), %ecx
	call	factorial
	addl	$4, %esp
	movl	%eax, %ebx
	movl	%ebp, %ecx
	movl	%ebx, -36(%ecx)
	movl	%ebp, %ecx
	movl	-36(%ecx), %ebx
	subl	$8, %esp
	pushl	%ebx
	pushl	$.LLC1
	call	printf
	addl	$16, %esp
.LL5:
	movl -4(%ebp),%eax
	popl	%edi
	popl	%esi
	popl	%ebx
	addl	$48, %esp
	leave
	ret
.LLfe5:
	.size	boo, .LLfe5-boo
	.section	.note.GNU-stack,"",@progbits
	.ident	"GCC: (GNU) 3.2.3 20030502 (Red Hat Linux 3.2.3-58)"
