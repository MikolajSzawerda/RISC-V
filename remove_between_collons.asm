	.data
test:	.string	"Il ][ barbiere ][ di Siviglia"
	.text
main:
	la a0, test
remove:
	li a1, '['
	li a2, ']'
	mv t1, a0
	mv t3, a0
left_collon_loop:
	lbu t2, (a0)
	addi a0, a0, 1
	beqz t2, remove_exit
	bne t2, a1, left_collon_loop
removing_loop:
	sb t2, (t1)
	addi t1, t1, 1
	addi a0, a0, 1
	lbu t2, (a0)
	beqz t2, remove_exit
	bne t2, a2, removing_loop
remove_exit_collon:
	sb t2, (t1)
	addi t1, t1, 1
remove_exit:
	sb zero, (t1)
	addi t1, t1, 1
	sub t3, t1, t3
	li a7, 1
	mv a0, t3
	ecall
	li a7, 4
	la a0, test
	ecall
exit:
	li a7, 10
	ecall