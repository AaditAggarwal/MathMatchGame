.data
	ques: .byte '?'
	bar: .byte '|'
	#ques_arr: .byte '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?'
.text
.globl flipToQues
.globl flipToBar
.globl check_ques

# flips a question mark to a bar
flipToBar:
	addiu $sp, $sp, -16
	sw $ra, 12($sp)
	sw $t0, 8($sp)
	sw $t1, 4($sp)
	sw $t2, 0($sp)

# goes to check.asm to check if the card is not already flipped
check_ques:

# get the integer value of column
	la $t0, ques_arr
	move $t1, $a1
	addi $t1, $t1, -97
	move $t2, $a2

# add the column to 4 * row 
	sll $t2, $t2, 2
	add $t2, $t2, $t1
	
	add $t0, $t0, $t2
	move $a1, $t0
	
# goes to checks.asm to check for validity
	jal first_flip
	lb $t1, bar
	sb $t1, 0($t0)
	j exit
		
# flips a value back to question mark
flipToQues:
	addiu $sp, $sp, -16
	sw $ra, 12($sp)
	sw $t0, 8($sp)
	sw $t1, 4($sp)
	sw $t2, 0($sp)

	la $t0, ques_arr
	move $t1, $a1
	addi $t1, $t1, -97
	move $t2, $a2
	
	sll $t2, $t2, 2
	add $t2, $t2, $t1
	
	add $t0, $t0, $t2
	la $t1, ques
	lb $t1, 0($t1)
	sb $t1, 0($t0)
	
	li $t1, 0
	la $t0, ques_arr
	j exit
exit:
	move $v1, $t2		#return the valid index to runGame to be checked for equality	
	lw $t2, 0($sp)
	lw $t1, 4($sp)
	lw $t0, 8($sp)
	lw $ra, 12($sp)
	addiu $sp, $sp, 16
	jr $ra
