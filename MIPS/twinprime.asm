.text
.globl main
main:
li $v0,4
la $a0,msg1
syscall

li $v0,5
syscall

move $s0,$v0

li $v0,4
la $a0,msg2
syscall

li $v0,5
syscall

move $s1,$v0

move $a0,$s0
jal isprime

move $a0,$s1
jal isprime

sub $a0,$s0,$s1
beq $a0,2,yes
beq $a0,-2,yes
j no

exit:
li $v0,10
syscall

yes:
li $v0,4
la $a0,msgy
syscall

li $v0,10
syscall

no:
li $v0,4
la $a0,msgn
syscall

li $v0,10
syscall

isprime:
li $t1,2
beq $a0,0,no
beq $a0,1,no

isprimeloop:
beq $t2,$a0,endisprime
div $a0,$t1
mfhi $s3
mflo $s4

beq $s3,0,no
addi $t2,$t2,1
j isprimeloop

endisprime:
jr $ra

.data
msg1: .asciiz "Enter the first number: "
msg2: .asciiz "Enter the second number: "
msgy: .asciiz "twin prime"
msgn: .asciiz "Not a twin prime"
