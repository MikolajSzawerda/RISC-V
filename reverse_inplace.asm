	.data
test:	.string "Wind On The Hill"
	.text
main:
	la a0, test
	jal reverse
	
	li a7, 1
	ecall
	
	li a7, 4
	la a0, test
	ecall
	
exit:
	li a7, 10
	ecall
reverse:
	mv t0, zero
	mv t1, a0
find_length:
	lbu t2, (a0)
	beq t2, zero, reverse_string
	addi a0, a0, 1
	b find_length
reverse_string:
	sub t5, a0, t1
	addi a0, a0, -1
reverse_loop:
	blt a0, t1, reverse_exit
	lbu t3, (t1)
	lbu t4, (a0)
	sb t4, (t1)
	sb t3, (a0)
	addi t1, t1, 1
	addi a0, a0, -1
	b reverse_loop
	
reverse_exit:
	mv a0, t5
	ret
