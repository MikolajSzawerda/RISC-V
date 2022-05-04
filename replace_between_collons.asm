	.data
test:	.string	"Eine ][ kleine ][ Nachtmusik"
test1:	.string	"Eine ][ kleine [ Nachtmusik"
test2:	.string	"Eine ] kleine ] Nachtmusik"
test3:	.string	"[Eine  kleine ] Nachtmusik]"
test4:	.string	""
	.text
main:
	la a0, test4
replace:
	li a1, '['
	li a2, ']'
	li a3, '*'
	mv t3, a0
left_collon_loop:
	lbu t2, (a0)
	addi a0, a0, 1
	beqz t2, replace_exit
	bne t2, a1, left_collon_loop
replacing:
	lbu t2, (a0)
	beq t2, a2, find_end_of_string
replacing_loop:
	sb a3, (a0)
	addi a0, a0, 1
	lbu t2, (a0)
	beqz t2, replace_exit
	bne t2, a2, replacing
find_end_of_string:
	addi a0, a0, 1
	lbu t2, (a0)
	bnez t2, find_end_of_string
replace_exit:
	sub t3, a0, t3
	li a7, 1
	mv a0, t3
	ecall
	li a7, 4
	la a0, test4
	ecall
exit:
	li a7, 10
	ecall