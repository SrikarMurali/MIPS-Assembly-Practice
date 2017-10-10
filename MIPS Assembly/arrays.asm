##arrays.asm - arrays practice


	.text
main:
	#reset $t0
	move	$t0, $0
while:
	beq		$t0, 12, exit
	
	lw		$t6, myArray($t0)
	
	add		$t0, $t0, 4

	#print current number
	li		$v0, 1
	move	$a0, $t6
	syscall
	
	li		$v0, 4
	la		$a0, newLine
	syscall
	
	
	j		while
exit:
	li		$v0, 10
	syscall
	
	.data
myArray:	.word 100, 2, 53
newLine:	.asciiz "\n"
