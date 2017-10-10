##fib.asm - ask for number and print out the fibonacci number
##int fib(int n) {
##	if(n<=1)
##		return n;
##	else
##		return fib(n-1) + fib(n-2)
##}
## Registers used
##	$a0		- messages/help incrementing
##	$v0		- final number fib(n-1) + fib(n-2) 
##	$s0		- changing/incrementing n
##	$s1		- fib(n-1)



	.text
main:
	li		$v0, 4
	la		$a0, start
	syscall
	
	li		$v0, 5 
	syscall
	move	$a0, $v0

	jal 	fib
	
	
	move	$a0, $v0
	li		$v0, 1
	syscall
	
	li		$v0, 10
	syscall
	

fib:
	sub		$sp, $sp, 12
	sw		$ra, 0($sp)		# save $ra
	sw		$s0, 4($sp)		# save retval fib(n-1)
	sw		$s1, 8($sp)		# save n
	
	add		$s0, $a0, $0
	addi	$t1, $0, 1

	beq		$s0, $0, zero
	addi	$a0, $s0, -1

	beq		$s0, $t1, one
	
	
	jal		fib
	
	add		$s1, $0, $v0
	addi	$a0, $s0, -2
	
	jal fib
	
	add		$v0, $v0, $s1
	
	j		exit	
zero:
	li		$v0, 0
	j		exit
	
one:
	li		$v0, 1
	j		exit
	
exit:
	lw		$ra, 0($sp)
	lw		$s0, 4($sp)
	lw		$s1, 8($sp)
	addi	$sp, $sp, 12
	jr		$ra

	
	
	.data
start:	.asciiz "Please enter a number: "