	.data
test: .string	"Implemented in ALGOL!"
	.text
main:
	la a0, test
remove:
	li a1, 'A'
	li a2, 'Z'
	mv t1, a0
	mv t3, a0
	
	lbu t2, (a0)
	addi a0, a0, 1
	beqz t2, remove_exit
remove_loop:
	blt t2, a1, next
	bgt t2, a2, next
	sb t2, (t1)
	addi t1, t1, 1
next:
	lbu t2, (a0)
	addi a0, a0, 1
	bnez t2, remove_loop
remove_exit:
	sb zero, (t1)
	sub a0, t1, t3
	li a7, 1
	ecall
	li a7, 4
	la a0, test
	ecall
exit:
	li a7, 10
	ecall
