	.data
test:	.string	"Computer Architecture LabB"
	.text
main:
	la a0, test
remove:
	li a1, 'a'
	li a2, 'z'
	mv t1, a0
	mv t3, a0
remove_loop:
	lbu t2, (a0)
	addi a0, a0, 1
	blt t2, a1, insert
	bleu t2, a2, remove_loop
insert:
	sb t2, (t1)
	addi t1, t1, 1
	bnez t2, remove_loop
remove_exit:
	addi t1, t1, -1
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
	