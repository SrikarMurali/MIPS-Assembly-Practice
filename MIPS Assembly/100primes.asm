
# Procedure: main
#       1. Iterate over the integers up to the 100th prime
#       2. Uses test_prime to to test if each integer is prime
#       3. Prints the first 100 numbers that are prime
#----------------------------------------------------------------

	.data
	.align 4
Done:		.asciiz "\nDone\n"
space:		.asciiz " "
newline:	.asciiz "\n"

	.text
	.globl main
main:
	add		$fp, $0, $sp	#frame pointer set
	add		$s0, $0, $0		#number of primes found
	add		$s1, $0, 100	#number of primes we are looking for
	add		$s2, $0, $0		#number we are checking
	add		$s3, $0, 10		#checks for when to do a new line	
	add		$s4, $0, 100	#checks	for when you have finished displaying the primes

main_loop:	
	beq		$s0, $s1, main_loop_done
	add		$a0, $0, $s2
	jal		test_prime
	beq		$v0, $0, prime_continue
	add		$s0, $s0, 1
	sub		$t0, $s2, $s3
	bgez	$t0, not_single
	li		$v0, 4
	la		$a0, space
	syscall
not_single:
	sub		$t0, $s2, $s4	
	bgez	$t0, not_double		#if prime is single go to another function, else continue
	li		$v0, 4
	la		$a0, space
	syscall
not_double:
	li		$2, 1		#syscall for print int
	add		$4, $0, $s2
	syscall
	li		$v0, 4		#print a space between numbers
	la		$a0, space
	syscall
	div		$s0, $s3	#if you have 10 primes on a line, do a new line
	mfhi	$t0
	bgtz	$t0, prime_continue
	li		$v0, 4
	la		$a0, space
	syscall
	
prime_continue:
	add		$s2, $s2, 1		#next number to check
	b		main_loop
main_loop_done:
	li		$v0, 4
	la		$a0, Done
	syscall
	li		$v0, 10
	syscall
	
	
# Procedure: test_prime
# Input: integer value n
# Return: 1 if n is prime and 0 if n is not prime
#
# of the callee saved registers the subroutine test_prime uses
# s2, s3 so we will save those to the stack
# as well as the old fp, and return pointers in 
# the beginng and restore them in the end.
# we will then set the new $fp to keep with convention
# although we dont ever use it



	.text
test_prime:
	add		$sp, $sp, -4
	sw		$ra, ($sp)
	add		$sp, $sp, -4
	sw		$fp, ($sp)
	add		$sp, $sp, -4
	sw		$s2, ($sp)
	add		$sp, $sp, -4
	sw		$s3, ($sp)
	add		$sp, $sp, -4
	add		$fp, $sp, 32
	add		$s2, $0, 1
	bne		$s2, $a0, not_one
	add		$v0, $0, $0
	b		exit_prime
	
not_one:
	addi	$s2, $0, 2
	beq		$a0, $s2, three_done
	div		$a0, $s2
	mfhi	$t0
	bgtz	$t0, three
	add		$v0, $0, $0
	b		exit_prime
three:
	add		$s2, $s2, 1

three_loop:
	add		$t0, $0, $0
	mult	$s2, $s2
	mflo	$s3
	sub		$t0, $a0, $s3
	bltz	$t0, three_done
	div		$a0, $s2
	mfhi	$t0
	bgtz	$t0, three_cont
	add		$v0, $0, $0
	b		exit_prime
	
three_cont:
	add		$s2, $s2, 2
	b		three_loop
three_done:
	add		$v0, $0, 1
exit_prime:
	add		$sp, $sp, 4
	lw		$s3, ($sp)
	add		$sp, $sp, 4
	lw		$s2, ($sp)
	add		$sp, $sp, 4
	lw		$fp, ($sp)
	add		$sp, $sp, 4
	lw		$ra, ($sp)
	add		$sp, $sp, 4
	jr		$ra
	