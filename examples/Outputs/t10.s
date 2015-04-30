	.file	"t10.p"
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
.LLfe0:
	.size	main, .LLfe0-main
	.globl boo
	.type	boo,@function
boo:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$84, %esp
	pushl	%ebx
	pushl	%esi
	pushl	%edi
	movl %ecx, -8(%ebp)
	movl	%ebp, %ecx
	subl	$8, %esp
	leal	-36(%ecx), %eax
	pushl	%eax
	pushl	$.LLC0
	call	scanf
	addl	$16, %esp
	movl	$0, %ebx
	movl	%ebp, %ecx
	movl	%ebx, -40(%ecx)
.LL1:
	movl	%ebp, %ecx
	movl	-40(%ecx), %ebx
	movl	%ebp, %ecx
	cmpl -36(%ecx), %ebx
	jle .LLt3
	movl $0, %ebx
	jmp .LLf3
.LLt3:	movl $1, %ebx
.LLf3:
	cmpl	$0, %ebx
	je	.LL2
	movl	%ebp, %ecx
	movl	-40(%ecx), %ebx
	movl	%ebp, %ecx
	imull	-40(%ecx), %ebx
	movl	%ebp, %ecx
	movl	%ebx, -16(%ebp)
	movl	%ebp, %ecx
	movl	-40(%ecx), %ebx
	subl	$1, %ebx
	movl	-16(%ebp), %eax
	movl	%eax, -80(%ecx,%ebx,4)
	movl	%ebp, %ecx
	movl	-40(%ecx), %ebx
	addl	$1, %ebx
	movl	%ebp, %ecx
	movl	%ebx, -40(%ecx)
	jmp	.LL1
.LL2:
	movl	$0, %ebx
	movl	%ebp, %ecx
	movl	%ebx, -40(%ecx)
.LL4:
	movl	%ebp, %ecx
	movl	-40(%ecx), %ebx
	movl	%ebp, %ecx
	cmpl -36(%ecx), %ebx
	jle .LLt6
	movl $0, %ebx
	jmp .LLf6
.LLt6:	movl $1, %ebx
.LLf6:
	cmpl	$0, %ebx
	je	.LL5
	movl	%ebp, %ecx
	movl	-40(%ecx), %ebx
	movl	%ebp, %ecx
	subl	$1, %ebx
	movl	-80(%ecx,%ebx,4), %eax
	movl	%eax, -16(%ebp)
	movl	-16(%ebp), %ebx
	subl	$8, %esp
	pushl	%ebx
	pushl	$.LLC1
	call	printf
	addl	$16, %esp
	movl	%ebp, %ecx
	movl	-40(%ecx), %ebx
	addl	$1, %ebx
	movl	%ebp, %ecx
	movl	%ebx, -40(%ecx)
	jmp	.LL4
.LL5:
.LL7:
	movl -4(%ebp),%eax
	popl	%edi
	popl	%esi
	popl	%ebx
	addl	$84, %esp
	leave
	ret
.LLfe7:
	.size	boo, .LLfe7-boo
	.section	.note.GNU-stack,"",@progbits
	.ident	"GCC: (GNU) 3.2.3 20030502 (Red Hat Linux 3.2.3-58)"
