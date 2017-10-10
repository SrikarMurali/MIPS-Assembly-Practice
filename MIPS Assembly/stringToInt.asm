#stringToInt- converts a string of a integer to an integer


##Registers used
##		$t0 - S
##		$t1 - character pointed to by S, the character
##		$t2 - current sum
##		$t3 - sign of number
##		$t4 - new line character 10
##		$t5 - used to test for overflow



	.text
main:
	la		$a0, string_space
	li		$a1, 1024
	li		$v0, 8
	syscall
	
	la		$t0, string_space
	li		$t2, 0
get_sign:
	li		$t3, 1
	lb		$t1, ($t0)
	bne		$t1, '-', positive
	li		$t3, -1
	addu	$t0, $t0, 1
	
positive:
	li		$t4, 10

sum_loop:
	lb		$t1, ($t0)
	addu	$t0, $t0, 1
	
	beq 	$t1, 10, end_sum_loop
	
	blt 	$t1, '0', end_sum_loop
	bgt		$t1, '9', end_sum_loop
	
	mult	$t2, $t4
	mfhi	$t5
	bnez	$t5, overflow
	mflo	$t2
	blt		$t2, $0, overflow
	
	sub		$t1, $t1, '0'
	add		$t2, $t2, $t1
	blt		$t2, $0, overflow
	
	b		sum_loop
	
end_sum_loop:
	mul 	$t2, $t2, $t3
	
	move	$a0, $t2
	li		$v0, 1
	syscall
	
	la		$a0, newline
	li		$v0, 4
	syscall
	
	b 		exit

overflow:
	la		$a0, overflow_msg
	li		$v0, 4
	syscall
	b		exit

exit:
	li		$v0, 10
	syscall
	
	
	.data
newline:		.asciiz "\n"
; string_space:	.space 1024
; overflow_msg:	.space 1024