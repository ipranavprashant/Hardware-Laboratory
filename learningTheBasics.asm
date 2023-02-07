;.data section is for the constants
;.bss section is for the variables
;.text section is for the Actual code


section .data
	msg:db "Hello World"
	msg_L:equ $-msg
;section .bss (As we do not need any variable for this)

section .text
;In text section we start by specifying that from where is our program going to start?
global _start:

_start:
;The command mov moves a piece of information to a register, here eax
;eax register stores the system call we are about to be running, system print is 4
mov eax,4 
;ebx register signifies ki where I have to write to, In our case we have to write it in the standard output device, so we'll use 1.
mov ebx,1
;ecx contains the label that links to the variable, here msg
mov ecx,msg
;edx contains the length of the variable
mov edx,msg_L           
;Now that we have set things up, inorder to trigger it we have to call the kernel
int 80h

;If we don't tell the program to end it will result into a segmentation fault
;Now we have to tell the program to end, we do so by telling the following commands
;eax register stores the system call we are about to be running, system exit is 1
mov eax,1
mov ebx,0
int 80h
