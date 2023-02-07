;print your name & address

section .data
name : db 'Jayaraj P B',10
l : equ $-name
add1 : db 'FC - 18, New Faculty Appartments',0ah
l1 : equ $-add1
add2 : db 'NIT Calicut',0ah
l2 : equ $-add2
add3 : db 'Kozikode, Kerala',0ah
l3 : equ $-add3

section .text

global _start:
_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, name
	mov edx, l
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, add1
	mov edx, l1
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, add2
	mov edx, l2
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, add3
	mov edx, l3
	int 80h

	mov eax, 1
	mov ebx, 0
	int 80h
