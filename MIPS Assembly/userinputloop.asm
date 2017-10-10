#simple loop which asks for user input and computes
#the sum of numbers until the users number, n
#a0		- message
#t0		- temp N
#t1		- counter
#t2		- sum
	.text
main:
	li		$v0, 4
	la		$a0, start
	syscall
	
	li		$v0, 5
	syscall
	move	$t0, $v0
	
	li		$t1, 0
	li		$t2, 0

loop:
	addi	$t1, $t1, 1
	add		$t2, $t2, $t1
	beq		$t0, $t1, exit
	j 		loop
	
exit:
	li		$v0, 4
	la		$a0, endNum
	syscall
	
	li		$v0, 1
	move	$a0, $t2
	syscall
	
	
	li		$v0, 10
	syscall


	.data
start:	.asciiz "Enter a number: "
endNum:	.asciiz "Your number is: "