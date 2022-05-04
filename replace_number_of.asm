	.data
test:	.string "aaaaaaaaaaaa"
	.text
main:
	la a0, test
replace:
	li a1, 'a'
	li a2, 'z'
	li a3, ' '
	mv t1, a0
	mv t3, zero
	li t4, 10
replace_loop:
	lbu t2, (a0)
	bleu t2, a3, fill
	addi a0, a0, 1
	bgtu t2, a2, replace_loop
	bltu t2, a1, replace_loop
	addi t3, t3, 1
	b replace_loop
fill:
	remu t3, t3, t4
	addi t3, t3, '0'
filling_loop:
	beq t1, a0, filling_exit
	sb t3, (t1)
	addi t1, t1, 1
	b filling_loop
filling_exit:
	addi a0, a0, 1
	addi t1, t1, 1
	mv t3, zero
	bnez t2, replace_loop
replace_exit:
	li a7, 4
	la a0, test
	ecall
exit:
	li a7, 10
	ecall
