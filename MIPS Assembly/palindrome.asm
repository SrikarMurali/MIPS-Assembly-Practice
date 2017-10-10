#palindrome.asm


	.text
main:
	la		$a0, string_space
	li 		$a1, 1024
	li		$v0, 8
	syscall
	
	la 		$t1, string_space
	la		$t2, string_space

length_loop:
	lb		$t3, ($t2)
	beqz	$t3, end_length_loop
	addu	$t2, $t2, 1
	b		length_loop
	
end_length_loop:
	subu	$t2, $t2, 2

test_loop:
	bge		$t1, $t2, is_palin
	
	lb		$t3, ($t1)
	lb		$t4, ($t2)
	bne		$t3, $t4, not_palin
	
	addu	$t1, $t1, 1
	subu	$t2, $t2, 1
	b test_loop
	
is_palin:
	la		$a0, is_palin_msg
	li		$v0, 4
	syscall
	b		exit
	
not_palin:
	la		$a0, not_palin_msg
	li		$v0, 4
	syscall
	b		exit
	
exit:
	li		$v0, 10
	syscall
	
	.data
string_space: 	.space 1024
is_palin_msg:	.asciiz "The string is a palindrome.\n"
not_palin_msg:	.asciiz "The string is not a palindrome.\n"
