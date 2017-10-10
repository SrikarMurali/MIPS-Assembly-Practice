#vowelRemover.asm - removes vowels

	.text

main:
	li		$v0, 4
	la		$a0, prompt
	syscall
	
	li		$v0, 8
	la		$a0, str
	li		$a1, 82
	syscall
	
	li		$t1, 0		# initialize index
	li	    $t3, 0		# vowel count

poploop:
	lb		$t0, str($t1)
	
	#check if vowel
	li		$t2, 'a'
	beq		$t0, $t2, vowel
	nop
	
	li		$t2, 'e'
	beq		$t0, $t2, vowel
	nop
	
	li		$t2, 'i'
	beq		$t0, $t2, vowel
	nop
	
	li		$t2, 'o'
	beq		$t0, $t2, vowel
	nop
	
	li		$t2, 'u'
	beq		$t0, $t2, vowel
	nop
	
	#if not a vowel, store it at current index in string less vowel count
	sub		$t2, $t1, $t3
	sb		$t0, str($t2)
	j		next
	nop
	
vowel:
	#if vowel increase vowel count
	add		$t3, $t3, 1
next:
	add		$t1, $t1, 1
	
	beqz	$t0, done			#once we reach null char, finish
	nop
	j		poploop
	nop
done:
	li		$v0, 4
	la		$a0, str
	syscall
	
	li		$v0, 10
	
	
	
	.data
prompt:		.asciiz "Please enter a string.\n"
str:		.space 82