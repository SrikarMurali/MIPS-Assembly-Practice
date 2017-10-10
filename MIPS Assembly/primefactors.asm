##primefactors.asm - calculates the prime factorization of a number


	.text
main:
	li		$v0, 4
	la		$a0, message1
	syscall
	
	li		$v0, 5
	syscall
	
	move	$t0, $v0
	bge		$t0, 100001, error
	
	blez	$t0, finished #if <= 0, then factorization is done
	beq		$t0, 1, notPrime	#1 is not prime
	
	li		$s0, 2 #dividing by this
	li		$k0, 0 #index for factors array when adding to array
	li		$k1, 0 #index when printing from array
	li		$t1, 0 #holds the quotient from each step
	li		$t2, 0 #hold the remainder
	
	move	$t1, $t0
factorize:
	div		$t1, $s0
	mfhi	$t2
	beqz	$t2, addToList
	add		$s0, $s0, 1
	ble		$s0, $t0, factorize
	b		showResult
addToList:
	mflo	$t1
	sw		$s0, factors($k0)
	add		$k0, $k0, 4
	b		factorize
	
notPrime:
	li		$v0,4
	la		$a0, one
	syscall
	b 		main
error:
	li		$v0, 4
	la		$a0, errorMess
	syscall
	
	b		main
showResult:
	li		$v0, 4
	la		$a0, message2
	syscall
	
	li		$v0, 1
	move	$a0, $t0
	syscall
	
	li		$v0, 4
	la		$a0, equalS
	syscall
	b		listFactors

	
times:
	li		$v0, 4
	la		$a0, multi
	syscall

listFactors:
	li		$v0, 1
	lw		$a0, factors($k1)
	syscall
	
	add		$k1, $k1, 4
	blt		$k1, $k0, times
	li		$v0, 4
	la		$a0, newline
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
message2:	.asciiz "Your prime factorization is: "
errorMess:	.asciiz "Too large"
one:		.asciiz "1 is not prime, no factorization"
multi:		.asciiz " * "
equalS:		.asciiz " = "  
end:		.asciiz "Program is terminating, thank you for your time! "
newline:	.asciiz "\n"
factors: .align 2 #align this to word addresses (divisible by 4)
		 .space 68 # 17 factors
		 
		 