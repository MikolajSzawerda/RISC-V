	.data
call_end:	.string "\n"
small_replace:	.string "Enter text to small letters replace\n"
big_replace:	.string "Enter text to big letters replace\n"
numbers_replace:	.string "Enter text to numbers replace\n"
text_reverse:	.string "Enter text to be reversed\n"
text_removed:	.string "Enter text to be trimed\n"
buf:	.space 100
	.text
main:
# small replacement
	li a7, 4
	la a0, small_replace
	ecall
	jal read_string
	la a0, buf
	li a1, 'a'
	li a2, 'z'
	jal replace
	jal present
# big replacement
	li a7, 4
	la a0, big_replace
	ecall
	jal read_string
	la a0, buf
	li a1, 'A'
	li a2, 'Z'
	jal replace
	jal present
# numbers replacement
	li a7, 4
	la a0, numbers_replace
	ecall
	jal read_string
	la a0, buf
	li a1, '1'
	li a2, '9'
	jal replace
	jal present
#reverse
	li a7, 4
	la a0, text_reverse
	ecall
	jal read_string
	la a0, buf
	jal reverse
	jal present
#remove
	li a7, 4
	la a0, text_removed
	ecall
	jal read_string
	la a0, buf
	jal remove
	jal present
	
exit:	
    li 	a7,10
    ecall

# REPLACE
#---------------------------
replace:
	mv t0, zero
	li t1, '*'

replace_loop:
	lbu t4, (a0)
	beq t4, zero, replace_exit
	addi a0, a0, 1
	bltu t4, a1, replace_loop
	bgtu t4, a2, replace_loop
	sb t1, -1(a0)
	addi t0, t0, 1
	b replace_loop
replace_exit:
	mv a0, t0
	ret
#---------------------------
#REVERSE
#---------------------------
reverse:
	mv t0, a0
	mv t3, zero
reverse_loop:
	lbu t1, (a0)
	beq t1, zero, reconstruct_string
	addi sp, sp, -1
	addi a0, a0, 1
	addi t3, t3, 1
	sb t1, (sp)
	b reverse_loop
reconstruct_string:
	mv t4, t3
reconstruct_string_loop:
	beqz t3, reverse_loop_exit
	lbu t1, (sp)
	sb t1, (t0)
	addi t0, t0, 1
	addi sp, sp, 1
	addi t3, t3, -1
	b reconstruct_string_loop
		
reverse_loop_exit:
	mv a0, t4
	ret
#---------------------------
#REMOVE
#---------------------------
remove:
	li a1, 'a'
	li a2, 'z'
	mv t1, a0
	mv t3, zero
remove_loop:
	lbu t2, (a0)
	addi a0, a0, 1
	beq t2, zero, remove_exit
	bgt t2, a2, replace_loop2
	blt t2, a1, replace_loop2
	b remove_loop
replace_loop2:
	sb t2, (t1)
	addi t1, t1, 1
	addi t3, t3, 1
	b remove_loop
	
remove_exit:
	sb zero, (t1)
	mv a0, t3
	ret
#---------------------------
#Utils
#---------------------------
read_string:
	la a0, buf
	li a1, 100
	li a7, 8
	ecall
	ret

present:
	li a7, 1
	ecall
	
	li a7, 4
	la a0, call_end
	ecall
	
	li a7, 4
	la a0, buf
	ecall
	
	li a7, 4
	la a0, call_end
	ecall
	ret
#---------------------------