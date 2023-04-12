.text
.globl main
main:

li $v0,4
la $a0,msg1
syscall

li $v0,5
syscall
move $s0,$v0

li $t7,4
mul $s0,$s0,$t7

li $t0,0

loop:
beq $t0,$s0,print_arr 

li $v0,5
syscall
move $t1,$v0

sw $t1,arr($t0)
addi $t0,$t0,4
j loop


print_arr:
li $t0,0

loop1:
beq $t0,$s0,exit

lw $t8,arr($t0)

li $v0,1
move $a0,$t8
syscall

li $v0,4
la $a0,nl
syscall

addi $t0,$t0,4
j loop1

exit:
li $v0,10
syscall

.data
msg1: .asciiz"enter the no. of elements in array: \n"
msg2: .asciiz"the elements are: \n"
msg3: .asciiz"sum is: \n"
arr: .space 40
nl: .asciiz "\n"

