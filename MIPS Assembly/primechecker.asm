##primechecker.asm - checks if number is prime


	.text
main:
	li		$v0, 4
	la		$a0, message1
	syscall
	
	li		$v0, 5
	syscall
	
	move	$t0, $v0		#use v0 for syscall so move the user value to $t0
	blez	$t0, finished	# if <= 0, then user ends the program
	
	#li		$v0, 1
	#move	$a0, $t0
	#syscall
	
	beq		$t0, 1, notPrime
	li		$s0, 2			#divide by this number
	div		$t0, $s0
	mflo	$k0				#contains quotient of half of the original number
testPrime:
	div		$t0, $s0
	mfhi	$t1
	beqz	$t1, notPrime
	add		$s0, $s0, 1
	beq		$s0, $k0, isPrime
	b		testPrime
	
isPrime:
	li		$v0, 4
	la		$a0, isPrimeM
	syscall
	b		main

notPrime:
	li		$v0, 4
	la		$a0, notPrimeM
	syscall
	
	beqz	$s0, return		#if not set yet, than you are on the first go through or branch
	la		$a0, divisible
	syscall
	
	li		$v0, 1
	move	$a0, $s0
	syscall
	
return:
	li		$v0, 4
	la		$a0, newLine
	syscall
	b		main

finished:
	li		$v0, 4
	la		$a0, end
	syscall
	
	li		$v0, 10
	syscall
	
	.data
	
message1:	.asciiz "Please enter a number: "
isPrimeM:	.asciiz "Your number is prime\n"
notPrimeM:	.asciiz "Your number is not prime\n"
divisible:	.asciiz "It was divisible by "
newLine:	.asciiz "\n"
end:		.asciiz "Program is terminating, thank you for your time.\n"