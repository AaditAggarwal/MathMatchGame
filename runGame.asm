.data
.globl gap
.globl clear
.globl enter
	space: .asciiz " "
	newLine: .asciiz "\n"
	clear: .asciiz "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
	gap: .asciiz "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
	smallGap: .asciiz "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
	enter: .asciiz "Enter column and row: "
	indices: .word 0, 0
	congrats: .asciiz "CONGRATULATIONS! YOU HAVE WON THE GAME!\n\n\n\n\n\n\n\n\n"
	secret_ending: .asciiz "\nSure. See you later!\n"
	lets_begin: .byte 'L', 'E', 'T', 'S', ' ', ' ', 'B', 'E', 'G', 'I', 'N'
.text
.globl run
.globl main
.globl indices
main:
	# sets up card arrays
	jal card_setup
	
	# prints rules
	jal rules
	li $v0, 12
	syscall
	move $s3, $v0
	
	# starts the game if 'y'
	bne $s3, 'y', secret_exit
	li $v0, 4
	la $a0, newLine
	syscall
	li $t0, 0
	li $t1, 0
	
	# prints the LETS BEGIN
	jal begin
	li $v0, 4
	la $a0, gap
	syscall
	li $s2, 0
	la $a3, 150
	
	# prints the matrix with a delay of 150ms for every line
	jal display
	jal slow_gap

# main run loop which goes over for 8 successful turns
run:
	la $s0, indices
	li $s1, 0
	beq $s2, 8, exit
while:
	# prompt for input
	li $v0, 4
	la $a0, enter
	syscall
	li $v0, 12
	syscall
	move $a1, $v0
	li $v0, 5
	syscall
	move $a2, $v0

	# flip a question mark to bar
	jal flipToBar
	move $t2, $v1
	sll $t2, $t2, 2
	sw $t2, 0($s0)
	addi $s0, $s0, 4
	li $a3, 0
	li $v0, 4
	la $a0, clear
	syscall
	jal display
	li $v0, 4
	la $a0, gap
	syscall
	addi $s1, $s1, 1

# check for products if 2 cards have been selected
	bne $s1, 2, while
	addi $s2, $s2, 1
	
# checks equality of products
	jal check_products
	j run

# subroutine for printing the LETS BEGIN
begin:
	addiu $sp, $sp, -4
	sw $ra, 0($sp)
begin_loop:
	li $t2, 0
	beq $t1, 2, reset_begin
	li $v0, 11
	lb $a0, lets_begin($t0)
	syscall
	li $v0, 4
	la $a0, space
	syscall
	li $t2, 0
	jal begin_sound
	li $v0, 32
	li $a0, 250
	syscall
	addi $t0, $t0, 1
	bne $t0, 11, begin_loop
	li $v0, 4
	la $a0, newLine
	syscall
	lw $ra, 0($sp)
	addiu $sp, $sp, 4
	jr $ra
	
reset_begin:
	li $t1, 0
	j begin_loop
	
exit:
	li $v0, 4
	la $a0, gap
	syscall
	li $v0, 32
	li $a0, 600
	syscall
	li $v0, 4
	la $a0, congrats
	syscall
	li $v0, 4
	la $a0, smallGap
	syscall
	jal congrats_sound
	li $v0, 10
	syscall
	
# secret exit when the player does not select 'y'
secret_exit:
	li $v0, 4
	la $a0, secret_ending
	syscall
	li $v0, 10
	syscall
