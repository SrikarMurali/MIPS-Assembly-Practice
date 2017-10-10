#multiple.asm


	.text
main:
	li		$v0, 5
	syscall
	move	$t0, $v0
	
	li		$v0, 5
	syscall
	move	$t1, $v0
	
	blez	$t1, exit
	
	mul		$t2, $t0, $t1
	move	$t3, $t0
	
loop:
	move	$a0, $t3
	li		$v0, 1
	syscall
	
	beq		$t2, $t3, endloop
	add		$t3, $t3, $t0
	

	
	b		loop
endloop:
		
	li		$v0, 10
	syscall
	
exit:
    li      $v0, 10              # terminate program run and
    syscall                      # Exit 

space:
	la 		$a0, 32
	li		$v0, 1
	syscall
	