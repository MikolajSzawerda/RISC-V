	.data
test:	.string	"Wind On The Hill."
	.text
main:
	la a0, test
convert:
	li a1, 'a'
	li a2, 'z'
	li a3, 'A'
	li a4, 'Z'
	li a5, '*'
convert_loop:
	lbu t2, (a0)
	addi a0, a0, 1
	blt t2, a3, replace
	bgt t2, a2, replace
	bleu t2, a2, convert_loop
	bgeu t2, a3, convert_loop
replace:
	sb a5, -1(a0)
	bnez t2, convert_loop
replace_exit:
	sb zero, -1(a0)
	li a7, 4
	la a0, test
	ecall
exit:
	li a7, 10
	ecall