	.data
test: .string	"hjkl01"
	.text
main:
	la a0, test
	jal base12
	
	li a7, 1
	ecall

exit:
	li a7, 10
	ecall

base12:
	li t1, '0'
	li t2, 'a'
	li t3, 10
	li t4, 2
find_begin:
	lbu t0, (a0)
	beq t0, zero, base12_exit
	mv t6, a0
	b find_loop
find_end:
	lbu t0, (a0)
	beq t0, zero, calculate_number
find_loop:
	addi a0, a0, 1
	sub t5, t0, t1
	bltu t5, t3, find_end
	sub t5, t0, t2
	bltu t5, t4, find_end
	b find_begin
	
calculate_number:
	mv a0, zero
calculate_loop:
	lbu t0, (t6)
	beq t0, zero, base12_exit
	addi t6, t6, 1
	sub t2, t0, t1
	bltu t2, t3, calculate_digit
	b calculate_letter
calculate_digit:
	add a0, a0, t2
	mv t2, a0
	slli t2, t2, 8
	slli a0, a0, 4
	add a0, a0, t2
	b calculate_loop
	
calculate_letter:
	sub t2, t0, t4
	addi t2, t2, 10
	add a0, a0, t2
	mv t2, a0
	slli t2, t2, 8
	slli a0, a0, 4
	add a0, a0, t2
	b calculate_loop
base12_exit:
	ret