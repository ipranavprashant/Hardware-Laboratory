section .data
	msg:db "Whats your name? ",10
	msg_L:equ $-msg
	greeting:db "Hello "
	greeting_L:equ $-greeting

section .bss
	name:resb 255

section .text

global _start:

_start:

mov eax,4 
mov ebx,1
mov ecx,msg
mov edx,msg_L           
int 80h

mov eax,3
mov ebx,0
mov ecx,name
mov edx,255
int 80h

mov eax,4
mov ebx,1
mov ecx,greeting
mov edx,greeting_L
int 80h

mov eax,4
mov ebx,1
mov ecx,name
mov edx,255
int 80h

mov eax,1
mov ebx,0
int 80h
