	.file	"t8.p"
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
	.globl moo
	.type	moo,@function
moo:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$36, %esp
	pushl	%ebx
	pushl	%esi
	pushl	%edi
	movl %ecx, -8(%ebp)
	movl	$303, %ebx
	movl	%ebp, %ecx
	movl	-8(%ecx), %ecx
	movl	-8(%ecx), %ecx
	movl	%ebx, -40(%ecx)
.LL0:
	movl -4(%ebp),%eax
	popl	%edi
	popl	%esi
	popl	%ebx
	addl	$36, %esp
	leave
	ret
.LLfe0:
	.size	moo, .LLfe0-moo
	.globl bar
	.type	bar,@function
bar:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$40, %esp
	pushl	%ebx
	pushl	%esi
	pushl	%edi
	movl %ecx, -8(%ebp)
	movl	$202, %ebx
	pushl	%ebx
#caller is parent
	movl	%ebp, %ecx
	call	moo
	addl	$4, %esp
.LL1:
	movl -4(%ebp),%eax
	popl	%edi
	popl	%esi
	popl	%ebx
	addl	$40, %esp
	leave
	ret
.LLfe1:
	.size	bar, .LLfe1-bar
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
.LLfe2:
	.size	main, .LLfe2-main
	.globl boo
	.type	boo,@function
boo:
	pushl	%ebp
	movl	%esp, %ebp
	subl	$52, %esp
	pushl	%ebx
	pushl	%esi
	pushl	%edi
	movl %ecx, -8(%ebp)
	movl	$0, %ebx
	movl	%ebp, %ecx
	movl	%ebx, -40(%ecx)
	movl	%ebp, %ecx
	movl	-40(%ecx), %ebx
	subl	$8, %esp
	pushl	%ebx
	pushl	$.LLC1
	call	printf
	addl	$16, %esp
	movl	$101, %ebx
	pushl	%ebx
#caller is parent
	movl	%ebp, %ecx
	call	bar
	addl	$4, %esp
	movl	%ebp, %ecx
	movl	-40(%ecx), %ebx
	subl	$8, %esp
	pushl	%ebx
	pushl	$.LLC1
	call	printf
	addl	$16, %esp
.LL3:
	movl -4(%ebp),%eax
	popl	%edi
	popl	%esi
	popl	%ebx
	addl	$52, %esp
	leave
	ret
.LLfe3:
	.size	boo, .LLfe3-boo
	.section	.note.GNU-stack,"",@progbits
	.ident	"GCC: (GNU) 3.2.3 20030502 (Red Hat Linux 3.2.3-58)"
