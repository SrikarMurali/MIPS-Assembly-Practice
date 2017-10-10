##factorial.asm - computes the factorial


	.text
main:
	li		$v0, 4
	la		$a0, start
	syscall
	
	li		$v0, 5
	syscall
	
	sw		$v0, theNumber
	#call the factorial function
	lw		$a0, theNumber
	jal		factorial
	sw		$v0, answer
	
	li		$v0, 4
	la		$a0, endN
	syscall
	
	li		$v0, 1
	lw		$a0, answer
	syscall
	
	li		$v0, 10
	syscall

factorial:
	
	sub		$sp, $sp, 8
	sw		$ra, ($sp)
	sw		$s0, 4($sp)
	
	#Base Case
	li		$v0, 1
	beq		$a0, 0, endFac
	
	#factorial(n-1)
	move	$s0, $a0
	sub		$a0, $a0, 1
	jal		factorial
	
	#Multiplication
	mul		$v0, $s0, $v0
endFac:
	lw		$ra, ($sp)
	lw		$s0, 4($sp)
	add		$sp, $sp, 8
	jr		$ra
	.data
start:		.asciiz "Enter a number: "
endN:		.asciiz "\nYour factorial is: "
theNumber:	.word	0
answer:		.word	0