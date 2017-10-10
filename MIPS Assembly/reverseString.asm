##reverseString.asm - reverses a string entered


	.text
main:
	li		$v0, 8
	la		$a0, str
	li		$a1, 128
	syscall
	
	li		$t0, 0		#new reversed string
	sub		$sp, $sp, 4
	sw		$t0, ($sp)
	li		$t1, 0		#index
	
pushl:
	lb		$t0, str($t1)
	beqz	$t0, stend
	
	sub		$sp, $sp, 4
	sw		$t0, ($sp)
	
	addu	$t1, 1
	j		pushl
stend:
	li		$t1, 0
	
popl:
	lw		$t0, ($sp)
	addu	$sp, $sp, 4
	beqz	$t0, done
	
	sb		$t0, str($t1)
	addu	$t1, 1
	j		popl
	
	
done:
	li		$v0, 4
	la		$a1, str
	syscall
	li		$v0, 10
	syscall
	
	.data
str:		.space 128