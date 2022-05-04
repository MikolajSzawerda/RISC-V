	.data
test:	.string	"Eine ][ kleine ][ Nachtmusik"
test1:	.string	"Eine ][ kleine [ Nachtmusik"
test2:	.string	"Eine ] kleine ] Nachtmusik"
test3:	.string	"[Eine  kleine ] Nachtmusik]"
test4:	.string	"[]"
	.text
main:
	la a0, test
	jal replace
	
	li a7, 1
	ecall
	
	li a7, 4
	la a0, test
	ecall
	#
	la a0, test1
	jal replace
	
	li a7, 1
	ecall
	
	li a7, 4
	la a0, test1
	ecall
	#
	la a0, test2
	jal replace
	
	li a7, 1
	ecall
	
	li a7, 4
	la a0, test2
	ecall
	#
	la a0, test3
	jal replace
	
	li a7, 1
	ecall
	
	li a7, 4
	la a0, test3
	ecall
	#
	la a0, test4
	jal replace
	
	li a7, 1
	ecall
	
	li a7, 4
	la a0, test4
	ecall
	#
	

exit:
	li a7, 10
	ecall

replace:
	li t1, '*'
	li t5, '['
	li t6, ']'
	mv t0, zero
replace_loop:
	lbu t2, (a0)
	beq t2, zero, replace_loop_exit
	addi a0, a0, 1
	addi t0, t0, 1
	beq t2, t5, no_change_loop
	sb t1, -1(a0)
	b replace_loop
no_change_loop:
	lbu t2, (a0)
	beq t2, zero, replace_loop_exit
	addi a0, a0, 1
	addi t0, t0, 1
	beq t2, t6, uncond_replace_loop
	b no_change_loop
uncond_replace_loop:
	lbu t2, (a0)
	beq t2, zero, replace_loop_exit
	sb t1, (a0)
	addi a0, a0, 1
	addi t0, t0, 1
	b uncond_replace_loop
	
replace_loop_exit:
	mv a0, t0
	ret