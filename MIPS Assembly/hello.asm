#Srikar Murali
#hello.asm - prints hello world

	.text
main:
	la $a0, hello_msg
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall
	
	.data
	hello_msg: .asciiz "Hello World!\n"