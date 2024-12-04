.data
	valid_divisors: .word 2, 3, 4, 5
	divisor1: .word 1
	divisor2: .word 1
	
.text
.globl get_divisors

# get two divisors for a value
get_divisors:	
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
	la $t1, valid_divisors
	
# goes over valid divisors and gets the first valid one
while:	
	lw $t0, 0($t1)		
	div $a1, $t0		
	mfhi $v0			
	beq $v0, $zero, tooLarge	
	addi $t1, $t1, 4		
	j while	
	
# checks if the divisor is greater than 5
tooLarge:
	mflo $v1			#v1 = quotient
	blt $v1, 6, returnSetup
	addi $t1, $t1, 4
	j while

#returns to card_setup
returnSetup:
	move $v0, $t0
	lw $ra, 0($sp)
	addiu $sp, $sp, 4	
	jr $ra	
