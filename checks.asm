.data
	ques: .byte '?'
	alreadyFlipped: .asciiz "The card is already flipped! Try again!: "
.text
.globl first_flip
.globl check_products

# check if the card is not already flipped
first_flip:
	lb $t3, ques
	move $t4, $a1
	lb $t4, 0($t4)
	beq $t4, $t3, flip_exit
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	jal wrong_flip_sound
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	li $v0, 4
	la $a0, alreadyFlipped
	syscall
	li $v0, 4
	la $a0, enter
	syscall
	li $v0, 12
	syscall 
	move $a1, $v0
	li $v0, 5
	syscall
	move $a2, $v0

# goes back to flip.asm to flip the card
	j check_ques


# checks if the products are equal
check_products:
	la $t7, indices
	lw $t5, 0($t7)
	lw $t5, divisor1_array($t5)
	lw $t6, 0($t7)
	lw $t6, divisor2_array($t6)
	mul $t4, $t6, $t5
	
	lw $t5, 4($t7)
	lw $t5, divisor1_array($t5)
	lw $t6, 4($t7)
	lw $t6, divisor2_array($t6)
	mul $t6, $t6, $t5

# goes back to runGame.asm if correct cards
	beq $t6, $t4, success_exit
	
# resets the cards back otherwise
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	
	la $t4, ques_arr
	lw $t5, 0($t7)
	srl $t5, $t5, 2
	add $t5, $t5, $t4
	lb $t6, ques
	sb $t6, 0($t5)
	
	lw $t5, 4($t7)
	srl $t5, $t5, 2
	add $t5, $t5, $t4
	lb $t6, ques
	sb $t6, 0($t5)
	jal reset_sound
	li $v0, 32
	li $a0, 1200
	syscall
	li $v0, 4
	la $a0, clear
	syscall
	li $a3, 0
	jal display
	li $v0, 4
	la $a0, gap
	syscall
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	addi $s2, $s2, -1
	jr $ra

flip_exit:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	jal flip_sound
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra	
	
success_exit:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	jal correct_sound
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra	
