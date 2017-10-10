#simple loop to add numbers
#t0		- increment
#t1		- multiplied
#t2 	- final of the given loop
	.text
main:
	li		$t0, 0
	li		$t1, 0
	li		$t2, 0
loop:
	bgt		$t0, 10, exit
	addi	$t0, $t0, 1
	add		$t1, $t0, $t0
	add		$t2, $t1, 3
	j 		loop

exit:
	move		$a0, $t2
	li			$v0, 1
	syscall
	jr 			$ra