	.data
test:	.string	"99:wind"
	.text
main:
	la a0, test
replace:
	li a1, '0'
	li a3, '*'
	lbu t0, (a0)
	sub t0, t0, a1
	lbu t1, 1(a0)
	sub t1, t1, a1
	addi a0, a0, 3
	mv a2, a0
find_end_of_string:
	lbu t2, (a0)
	addi a0, a0, 1
	bnez t2, find_end_of_string
prepare_replacing:
	add t0, t0, a2
	sub t1, a0, t1
	addi t1, t1, -1
	blt t1, t0, replace_exit
replacing:
	sb a3, (t0)
	addi t0, t0, 1
	bne t0, t1, replacing
replace_exit:
	li a7, 4
	la a0, test
	ecall
exit:
	li a7, 10
	ecall