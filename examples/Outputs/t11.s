	.file	"t11.p"
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
	subl	$60, %esp
	pushl	%ebx
	pushl	%esi
	pushl	%edi
	movl %ecx, -8(%ebp)
	movl	$2, %ebx
	movl	%ebp, %ecx
	movl	%ebx, -48(%ecx)
	movl	$1, %ebx
	movl	%ebp, %ecx
	movl	%ebx, -52(%ecx)
	movl	$3, %ebx
	movl	%ebp, %ecx
	movl	%ebx, -56(%ecx)
	movl	%ebp, %ecx
	movl	-48(%ecx), %ebx
	movl	%ebp, %ecx
	movl	-52(%ecx), %esi
	movl	%ebp, %ecx
	addl	-56(%ecx), %esi
	imull	%esi, %ebx
	movl	%ebp, %ecx
	movl	-48(%ecx), %esi
	movl	%ebp, %ecx
	movl	-52(%ecx), %edi
	movl	%ebp, %ecx
	addl	-56(%ecx), %edi
	imull	%edi, %esi
	addl	%esi, %ebx
# gencode() panic mode: begin
	movl	%ebx, -32(%ebp)
	movl	%ebp, %ecx
	movl	-48(%ecx), %ebx
	movl	%ebp, %ecx
	movl	-52(%ecx), %esi
	movl	%ebp, %ecx
	addl	-56(%ecx), %esi
	imull	%esi, %ebx
	movl	%ebp, %ecx
	movl	-48(%ecx), %esi
	movl	%ebp, %ecx
	movl	-52(%ecx), %edi
	movl	%ebp, %ecx
	addl	-56(%ecx), %edi
	imull	%edi, %esi
	addl	%esi, %ebx
	movl	-32(%ebp), %eax
	imull	%eax, %ebx
# gencode() panic mode: end
	movl	%ebp, %ecx
	movl	%ebx, -36(%ecx)
	movl	%ebp, %ecx
	movl	-36(%ecx), %ebx
	subl	$8, %esp
	pushl	%ebx
	pushl	$.LLC1
	call	printf
	addl	$16, %esp
.LL1:
	movl -4(%ebp),%eax
	popl	%edi
	popl	%esi
	popl	%ebx
	addl	$60, %esp
	leave
	ret
.LLfe1:
	.size	boo, .LLfe1-boo
	.section	.note.GNU-stack,"",@progbits
	.ident	"GCC: (GNU) 3.2.3 20030502 (Red Hat Linux 3.2.3-58)"
