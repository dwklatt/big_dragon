	.file	"t7b.p"
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
	.globl foo
	.type	foo,@function
foo:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$36, %esp
	pushl	%ebx
	pushl	%esi
	pushl	%edi
	movl %ecx, -8(%ebp)
	movl	%ebp, %ecx
	movl	8(%ecx), %ebx
	pushl %edx
	pushl %eax
	movl %ebx, %eax
	cltd
	movl $10, %ebx
	idivl %ebx
	movl %edx, %ebx
	popl %eax
	popl %edx
	movl	%ebx, -4(%ebp)
.LL0:
	movl -4(%ebp),%eax
	popl	%edi
	popl	%esi
	popl	%ebx
	addl	$36, %esp
	leave
	ret
.LLfe0:
	.size	foo, .LLfe0-foo
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
.LLfe1:
	.size	main, .LLfe1-main
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
	leal	-36(%ecx), %eax
	pushl	%eax
	pushl	$.LLC0
	call	scanf
	addl	$16, %esp
	movl	%ebp, %ecx
	movl	-36(%ecx), %ebx
	pushl	%ebx
#caller is not parent
	movl	-8(%ebp), %ecx
	call	foo
	addl	$4, %esp
	movl	%eax, %ebx
	movl	%ebp, %ecx
	movl	%ebx, -40(%ecx)
	movl	%ebp, %ecx
	movl	-40(%ecx), %ebx
	subl	$8, %esp
	pushl	%ebx
	pushl	$.LLC1
	call	printf
	addl	$16, %esp
.LL2:
	movl -4(%ebp),%eax
	popl	%edi
	popl	%esi
	popl	%ebx
	addl	$48, %esp
	leave
	ret
.LLfe2:
	.size	boo, .LLfe2-boo
	.section	.note.GNU-stack,"",@progbits
	.ident	"GCC: (GNU) 3.2.3 20030502 (Red Hat Linux 3.2.3-58)"
