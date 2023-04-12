.text
.globl main
main:

move $t0,$v0
li $t2,0
li $t3,10
li $t4,1
li $t5,0
li $t6,0
li $t7,0
li $t8,1
li $t9,2
li $t1,3
li $v0,4
la $a0,msg2
syscall


li $v0,5
syscall
move $t2,$v0

div $t2,$t3
mfhi $t5


mflo $t2
div $t2,$t3
mfhi $t6


mflo $t2
div $t2,$t3
mfhi $t7

exit:
li $v0,4
la $a0,msg3
syscall

move $a0,$t5
li $v0,1
syscall

li $v0,4
la $a0,msg4
syscall

move $a0,$t6
li $v0,1
syscall

li $v0,4
la $a0,msg5
syscall

move $a0,$t7
li $v0,1
syscall

li $v0,10
syscall

.data
msg2: .asciiz "Enter the number: "
msg3: .asciiz "The digit1 is: "
msg4: .asciiz "The digit2 is: "
msg5: .asciiz "The digit3 is: "
