	.data
test:	.string	"oi:ioasdddasewaoasdasdasdizcggsdfsdfsdfoioioioioii"
	.text
main:
	la a0, test
	jal replace
	
	li a7, 4
	la a0, test
	ecall

exit:
	li a7, 10
	ecall

replace:
	mv t0, a0
	lbu t1, (a0)
	lbu t2, 1(a0)
	addi a0, a0, 3 
	li t6, '*'
replace_loop_begin:
	lbu t3, (a0)
	beq t3, zero, replace_exit
	mv t4, a0
	addi a0, a0, 1
	beq t3, t1, replace_loop_end
	b replace_loop_begin
replace_loop_end:
	lbu t3, (a0)
	beq t3, zero, replace_exit
	mv t5, a0
	addi a0, a0, 1
	beq t3, t2, replacing_loop
	b replace_loop_end
replacing_loop:
	sb t6, (t4)
	beq t4, t5, replace_exit_spacing
	addi t4, t4, 1
	b replacing_loop
replace_exit_spacing:
	li t6, ' '
	sb t6, (t0)
	sb t6, 1(t0)
	sb t6, 2(t0)
	ret
replace_exit:
	ret