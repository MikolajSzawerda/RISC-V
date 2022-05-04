	.data
test:	.string	"Wind ON The HiLL"
	.text
main:
	la a0, test
replace:
	li a1, ' '
	li a2, 'A'
	li a3, 'Z'
next_word:
	mv t0, zero
	mv t1, a0
find_end_of_word:
	lbu t2, (a0)
	addi a0, a0, 1
	bgt t2, a3, find_end_of_word
	bgeu t2, a2, increment
	bgt t2, a1, find_end_of_word
replacing:
	 addi t0, t0, '0'
	 addi a0, a0, -1
replacing_loop:
	sb t0, (t1)
	addi t1, t1, 1
	bne t1, a0, replacing_loop
replacing_exit:
	addi a0, a0, 1
	bnez t2, next_word
replace_exit:
	li a7, 4
	la a0, test
	ecall
exit:
	li a7, 10
	ecall

increment:
	addi t0, t0, 1
	b find_end_of_word
