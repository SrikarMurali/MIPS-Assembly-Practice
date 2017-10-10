##uppertolower.asm - changees uppercase to lowercase


	.text
main:
	la		$t0, string 		#load the string
while:
	toLowerCase:
		lb		$t2, ($t0)		#get first byte and store it in $t2
		beqz	$t2, end		#if equal to zero the string is done
		li		$t1, 'A'		#get A and branch if $t2 is greater than $t1, which means it is uppercase
		bge		$t2, $t1, uppercaseTest2
		j continue
		
	uppercaseTest2:
		li		$t1, 'Z' 			#check if it is before 'Z'
		ble		$t2, $t1, uppercase	#lowered if less than or equal to 'Z'
		
	continue:
		add		$t0, $t0, 1
		j		toLowerCase
		

	
	
uppercase:
	add		$t2, $t2, 32			#add 32 to turn it into a lowercase
	sb		$t2, ($t0)				#store it in a string
	j		continue				#continue
	
end:
	#print the string
	li		$v0, 4
	la		$a0, string
	syscall
	
	li		$v0, 10
	syscall

	
	
	.data
string:		.asciiz "CAt iN ThE HAt\n"
