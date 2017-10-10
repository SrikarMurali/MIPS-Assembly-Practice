#maxArray.asm - finds the max in the array
	
	
	

	.text	
main:
	la		$a0, myArray 	#initialize pointer
	add		$a1, $0, 8		#total elements in array
	jal		max				#call max function			
	j		finish
	
	
max:
	add		$t7, $0, $0		#make index 0
	add		$t2, $0, $0		#current max
	
	
maxLoop:
	beq		$t7, $a1, stop	#stop if at the end of array
	lw		$t3, 0($a0)		#get element at current index
	slt		$t1, $t3, $t2	#if current element is less $t1 = 1, else $t1 = 0
	
	bne		$t1, $0, notmax	#if value is less that current max call notmax
	
	add		$t2, $t3, $0	#update if value is greater than current max

notmax:
	add		$t7, $t7, 1		#increment index by 1
	add		$a0, $a0, 4		#go to next element
	j		maxLoop			
	
stop:
	jr		$ra
	
finish:
	add		$a2, $t2, $0	#put max in $a2
	move	$a0, $a2		#move max to $a0
	li		$v0, 1			#print the max
	syscall

	.data
myArray:	.word	12, 1, 24, 14, 54, 65, 45, 87
newLine:	.asciiz "\n"
