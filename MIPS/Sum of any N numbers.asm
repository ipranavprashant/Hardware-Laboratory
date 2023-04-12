.text
.globl main
main:
li $v0,4
la $a0,msg1
syscall

li $v0,5
syscall

move $t0,$v0
li $t1,0
li $t2,0
li $t3,0

li $v0,4
la $a0,msg2
syscall

loop:
addi $t1,$t1,1
li $v0,5
syscall
move $t3,$v0
add $t2,$t2,$t3
beq $t1,$t0,exit
j loop

exit:
li $v0,4
la $a0,msg3
syscall

move $a0,$t2
li $v0,1
syscall

li $v0,10
syscall

.data
msg1: .asciiz "Enter the number of entries"
msg2: .asciiz "Enter the entries itself"
msg3: .asciiz "The sum of the entries is"
