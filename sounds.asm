.data
	pitch: .byte 75
	wrong_pitch: .byte 30
	correct_pitch: .byte 70
	pitch_e: .byte 64
	pitch_c: .byte 60
	pitch_g: .byte 67
	pitch_eb: .byte 63
	pitch_ff: .byte 66
	duration: .word 250
	duration_1: .word 250
	duration_2: .word 450
	reset_instrument: .byte 96
	flip_instrument: .byte 120
	begin_instrument: .byte 9, 10
	wrong_instrument: .byte 48
	congrats_instrument: .byte 0
	volume: .byte 75
	flip_volume: .byte 127
	congrats_volume: .byte 127
.text
.globl begin_sound
.globl flip_sound
.globl wrong_flip_sound
.globl congrats_sound
.globl correct_sound
.globl reset_sound

congrats_sound:
	li $t0, 0
	lb $a0, pitch_e($t0)
	lw $a1, duration_1($t0)
	lb $a2, congrats_instrument($t0)
	lb $a3, congrats_volume($t0)
	li $v0, 31
	syscall
	li $v0, 32
	li $a0, 250
	syscall
	lb $a0, pitch_e($t0)
	lw $a1, duration_1($t0)
	lb $a2, congrats_instrument($t0)
	lb $a3, congrats_volume($t0)
	li $v0, 31
	syscall
	li $v0, 32
	li $a0, 500
	syscall
	lb $a0, pitch_e($t0)
	lw $a1, duration_1($t0)
	lb $a2, congrats_instrument($t0)
	lb $a3, congrats_volume($t0)
	li $v0, 31
	syscall
	li $v0, 32
	li $a0, 500
	syscall
	lb $a0, pitch_c($t0)
	lw $a1, duration_1($t0)
	lb $a2, congrats_instrument($t0)
	lb $a3, congrats_volume($t0)
	li $v0, 31
	syscall
	li $v0, 32
	li $a0, 250
	syscall
	lb $a0, pitch_e($t0)
	lw $a1, duration_2($t0)
	lb $a2, congrats_instrument($t0)
	lb $a3, congrats_volume($t0)
	li $v0, 31
	syscall
	li $v0, 32
	li $a0, 500
	syscall
	lb $a0, pitch_g($t0)
	lw $a1, duration_2($t0)
	lb $a2, congrats_instrument($t0)
	lb $a3, congrats_volume($t0)
	li $v0, 31
	syscall
	jr $ra

reset_sound:
	li $s4, 0
	lb $a0, pitch_eb($s4)
	lw $a1, duration_1($s4)
	lb $a2, reset_instrument($s4)
	lb $a3, flip_volume($s4)
	li $v0, 31
	syscall
	li $v0, 32
	li $a0, 250
	syscall
	li $s4, 0
	lb $a0, pitch_c($s4)
	lw $a1, duration_1($s4)
	lb $a2, reset_instrument($s4)
	lb $a3, flip_volume($s4)
	li $v0, 31
	syscall
	li $v0, 32
	li $a0, 250
	syscall
	li $s4, 0
	lb $a0, pitch_ff($s4)
	li $a1, 1500
	lb $a2, reset_instrument($s4)
	lb $a3, flip_volume($s4)
	li $v0, 31
	syscall
	jr $ra

correct_sound:
	li $s4, 0
	lb $a0, correct_pitch($s4)
	li $a1, 200
	lb $a2, wrong_instrument($s4)
	lb $a3, flip_volume($s4)
	li $v0, 31
	syscall
	li $v0, 32
	li $a0, 200
	syscall
	li $s4, 0
	lb $a0, pitch($s4)
	li $a1, 200
	lb $a2, wrong_instrument($s4)
	lb $a3, flip_volume($s4)
	li $v0, 31
	syscall
	jr $ra

wrong_flip_sound:
	li $s4, 0
	lb $a0, wrong_pitch($s4)
	lw $a1, duration($s4)
	lb $a2, wrong_instrument($s4)
	lb $a3, flip_volume($s4)
	li $v0, 31
	syscall
	jr $ra
	
flip_sound:
	lb $a0, pitch($s4)
	lw $a1, duration($s4)
	lb $a2, flip_instrument($s4)
	lb $a3, flip_volume($s4)
	li $v0, 31
	syscall
	jr $ra
	
begin_sound:
	lb $a0, pitch($t2)
	lw $a1, duration($t2)
	lb $a2, begin_instrument($t1)
	lb $a3, volume($t2)
	li $v0, 31
	syscall
	addi $t1, $t1, 1
	jr $ra