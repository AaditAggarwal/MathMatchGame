.data
.globl divisor1_array
.globl divisor2_array
.globl ques_arr
	ques_arr: .byte '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?'
	index_array: .word 4, 8, 12, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60, 64
	divisor2_array: .space 64
	card_values: .word 4, 6, 8, 9, 10, 12, 15, 16, 20, 25
	divisor1_array: .word 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
	space: .asciiz " "
	next_line: .asciiz "\n"
.text
.globl card_setup
# initializes divisor1 and divisor2 arrays
card_setup:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	la $s1, divisor1_array
	la $s2, divisor2_array
	la $s3, card_values
	li $t5, 0			# t5 = iterator

#loops 8 times to get 8 pairs
setup:
	beq $t5, 8, exit
	li $a1, 10
	
# randomizer to get one of the numbers from card_values
	jal randomizer		# v1 = random index * 4
	add $s3, $s3, $v1	# s3 += v1
	lw $t6, 0($s3)		# t6 = card_values[v1]
	la $s3, card_values	
	la $a1, 16
	
# randomizer to get one of the index for divisor array
	jal randomizer		# v1 =  random index for divisor array
	move $t3, $v1		# t3 = v1
	jal index_selector	
	sw $zero, 0($t2)		# index_array[index] = 0
	add $t3, $s2, $t3		# t3 = divisor2_array[index]
	sw $t6, 0($t3)		# t3[index] = a1
	move $a1, $t6

# get divisors in v0 and v1
	jal get_divisors
	move $t0, $v0
	move $t1, $v1		# t0 = v0, t1 = v1
	la $a1, 16
	jal randomizer
	move $t3, $v1
	jal index_selector
	sw $zero, 0($t2)
	add $t4, $s1, $t3		# t4 = divisor1_array[index]
	add $t3, $s2, $t3		# t3 = divisor2_array[index]
	sw $t0, 0($t3)		
	sw $t1, 0($t4)
	addi $t5, $t5, 1		# t5++
	j setup

randomizer:
	li $v0, 42
	syscall
	move $v1, $a0
	sll $v1, $v1, 2
	jr $ra

# iterators over available indices if the randomly selected one was occupied
index_selector:
	la $t2, index_array
	beq $t3, 64, reset_index	# if (index == 64) -> index = 0
	add $t2, $t2, $t3			# t2 += index
	lw $t4, 0($t2)			# t4 = t2[index]
	bne $t4, $zero, return		# return if (t4 != 0)
	add $t3, $t3, 4
	j index_selector

# resets the index to beginning of divisor array
reset_index:
	li $t3, 0
	j index_selector

# subroutine to return
return:
	jr $ra

exit:
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra
