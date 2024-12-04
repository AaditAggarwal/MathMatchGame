.data
	#ques_arr: .byte '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?'
	topscore: .asciiz "  +-------+-------+-------+-------+\n"
	columns: .asciiz "      a       b       c       d\n"
	bar: .byte '|'
	X: .asciiz "X"
	space1: .asciiz " "
	space2: .asciiz "  "
	space3: .asciiz "   "  # 3 spaces
	newline: .asciiz "\n"
	welcome: .asciiz "			       MATH MATCH GAME\n\nPLEASE EXPAND I/O AREA FOR BEST EXPERIENCE (CLICK THE SMALL UPWARD FACING ARROW)\n\n"
	rule0: .asciiz "			    HOW TO PLAY THE GAME\n\n"
	rule1: .asciiz "1) Each card with '?' contains a value (or multiplication expression)\n"
	rule2: .asciiz "2) You need to select 2 cards with the same value/expression (e.g. 20 and 4 x 5)\n"
	rule3: .asciiz "3) Selecting the correct cards will lock the cards in place\n"
	rule4: .asciiz "4) Selecting two cards with different value/expression will reset those cards to '?'\n"
	rule5: .asciiz "5) You cannot select a card which has been already flipped\n"
	rule6: .asciiz "6) IMPORTANT: To select a card, enter it's column and row together\n"
	rule7: .asciiz "7) IMPORTANT: To select a card (for e.g.) in column b and row 3, input b3\n"
	rule8: .asciiz "8) You are now ready to play the game.\nEnter 'y' to play game: "
	
.text
.globl display
.globl rules
.globl slow_gap
display:
	addiu $sp, $sp, -16
	sw $ra, 12($sp)
	sw $t1, 8($sp)
	sw $t2, 4($sp)
	sw $t3, 0($sp)
	# Print the top border
	la $a1, columns
	jal printString
	la $a1, topscore
	jal printString

	li $t1, 0                # Row counter
	la $t2, ques_arr         # Pointer to ques_arr (start of array)
	lb $t3, bar
	li $t6, 0	# index
	
# loop for printing each row
row_loop:
	beq $t1, 4, exit  # Exit after 4 rows
	li $v0, 32
	move $a0, $a3
	syscall
	# Print a single row
	li $t0, 0                # Column counter
	li $v0, 1
	move $a0, $t1
	syscall
	la $a1, space1
	jal printString
	
	# loop for printing each column
	print_row_start:
		# Print left border '|'
		la $t2, ques_arr
		lb $a1, bar
		jal printChar
		
		add $t2, $t2, $t6
		lb $a1, 0($t2)
		beq $a1, $t3, printDivisors

		# Print 3 spaces
		la $a1, space3
		jal printString
		
		# Print character from ques_arr
		lb $a1, 0($t2)         # Load the current character from ques_arr
		jal printChar
		
		addi $t6, $t6, 1
		
		# Print 3 spaces
		la $a1, space3
		jal printString

returnLoop:
		# Increment column counter
		addi $t0, $t0, 1
		bne $t0, 4, print_row_start

		# Print right border '|'
		lb $a1, bar
		jal printChar

		# Move to the next line
		li $v0, 4
		la $a0, newline
		syscall

	# Print divider line after the row
	la $a1, topscore
	jal printString

	addi $t1, $t1, 1          # Increment row counter
	j row_loop

printString:
	li $v0, 4
	move $a0, $a1
	syscall
	jr $ra

printChar:
	li $v0, 11
	move $a0, $a1
	syscall
	jr $ra

# print the divisors in each card slot
printDivisors:
	la $t4, divisor1_array
	la $t5, divisor2_array
	addiu $sp, $sp, -4
	sw $t0, 0($sp)
	sll $t6, $t6, 2
	add $t4, $t4, $t6
	add $t5, $t5, $t6
	srl $t6, $t6, 2
	addi $t6, $t6, 1
	lw $t0, 0($t4)
	beq $t0, 1, printValue
	li $v0, 4
	la $a0, space1
	syscall
	li $v0, 1
	lw $a0, 0($t4)
	syscall
	li $v0, 4
	la $a0, space1
	syscall
	li $v0, 4
	la $a0, X
	syscall
	li $v0, 4
	la $a0, space1
	syscall
	li $v0, 1
	lw $a0, 0($t5)
	syscall
	li $v0, 4
	la $a0, space1
	syscall
	lw $t0, 0($sp)
	addiu $sp, $sp, 4
	j returnLoop

# prints the value in a card slot
printValue:
	lw $t0, 0($t5)
	bge $t0, 10, printSpace2
	li $v0, 4
	la $a0, space3
	syscall
	
returnValue:
	li $v0, 1
	lw $a0, 0($t5)
	syscall
	li $v0, 4
	la $a0, space3
	syscall
	lw $t0, 0($sp)
	addiu $sp, $sp, 4
	j returnLoop
	
printSpace2:
	li $v0, 4
	la $a0, space2
	syscall
	j returnValue

# prints rules
rules:
	li $v0, 4
	la $a0, welcome
	syscall
	li $v0, 32
	li $a0, 1500
	syscall
	li $v0, 4
	la $a0, rule0
	syscall
	li $v0, 32
	li $a0, 1500
	syscall
	li $v0, 4
	la $a0, rule1
	syscall
	li $v0, 32
	li $a0, 1500
	syscall
	li $v0, 4
	la $a0, rule2
	syscall
	li $v0, 32
	li $a0, 1500
	syscall
	li $v0, 4
	la $a0, rule3
	syscall
	li $v0, 32
	li $a0, 1500
	syscall
	li $v0, 4
	la $a0, rule4
	syscall
	li $v0, 32
	li $a0, 1500
	syscall
	li $v0, 4
	la $a0, rule5
	syscall
	li $v0, 32
	li $a0,1500
	syscall
	li $v0, 4
	la $a0, rule6
	syscall
	li $v0, 32
	li $a0, 1500
	syscall
	li $v0, 4
	la $a0, rule7
	syscall
	li $v0, 32
	li $a0,1500
	syscall
	li $v0, 4
	la $a0, rule8
	syscall
	jr $ra

# creates a gap slowly for the first time a matrix is diplayed
slow_gap:
	li $t0, 0
	while:
	beq $t0, 40, run
	addi $t0, $t0, 1
	li $v0, 32
	li $a0, 100
	syscall
	li $v0, 4
	la $a0, newline
	syscall
	j while

exit:
	li $v0, 4
	la $a0, newline
	syscall
	lw $t3, 0($sp)
	lw $t2, 4($sp)
	lw $t1, 8($sp)
	lw $ra, 12($sp)
	addiu $sp, $sp, 16
	jr $ra
