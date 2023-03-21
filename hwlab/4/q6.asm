;Made by Pranav Prashant
;Inorder to run this program:
;Compile: nasm -f elf q4.asm
;Link: ld -melf_i386 q3.o -o q3

section .bss
string: resb 100
string_len: resw 1
char: resb 1
temp: resb 1
ans: resw 1
num: resw 1
count: resb 1
i: resw 1

section .data
msg1: db "Enter the string: "
len1: equ $-msg1
msg2: db "Enter the beginning Index : "
len2: equ $-msg2
msg3: db "Enter the End Index : "
len3: equ $-msg3
newline: db 10
zero: db 0

global _start
section .text
_start:

mov eax, 4
mov ebx, 1
mov ecx, msg1
mov edx, len1
int 80h

call read_string
;call print_string

mov ax, word[string_len]
mov word[num], ax
;call print_num

mov eax, 0
mov ebx, string

pusha
mov eax, 4
mov ebx, 1
mov ecx, msg2
mov edx, len2
int 80h
popa
call read_num
;sub word[num],1

while1:
cmp ax, word[num]
je end_while1

inc eax
jmp while1

end_while1:
pusha
mov eax, 4
mov ebx, 1
mov ecx, msg3
mov edx, len3
int 80h
popa
call read_num

while:
cmp ax, word[num]
je end

mov cl, byte[ebx+eax]
mov byte[temp], cl

pusha
mov eax, 4
mov ebx, 1
mov ecx,     temp
mov edx, 1
int 80h
popa

inc eax
jmp while

end:
mov eax, 1
int 80h


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

mov word[string_len], 0
read_string:
mov ebx, string
mov eax, 0
pusha 

reading:
pusha
mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h
popa

cmp byte[temp], 10
je end_reading
inc word[string_len]
mov cl, byte[temp]
mov byte[ebx+eax], cl
inc eax
jmp reading

end_reading:
mov byte[ebx+eax], 0
popa
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

print_string:
mov ebx, string
pusha
printing:
mov al, byte[ebx]
cmp al, 0
je end_printing

mov byte[temp], al
push ebx
mov eax, 4
mov ebx, 1
mov ecx, temp
mov edx, 1
int 80h
pop ebx
inc ebx
jmp printing

end_printing:
mov eax, 4
mov ebx, 1
mov ecx, newline
mov edx, 1
int 80h
popa
ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

read_num:

	pusha
	mov word[num], 0

loop_read:

	mov eax, 3
	mov ebx, 0
	mov ecx, temp
	mov edx, 1
	int 80h
	cmp byte[temp], 10
	je end_read
	mov ax, word[num]
	mov bx, 10
	mul bx
	mov bl, byte[temp]
	sub bl, 30h
	mov bh, 0
	add ax, bx
	mov word[num], ax
	jmp loop_read

end_read:

popa
ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


print_num:
	cmp word[num],0
	je printzero
	mov byte[count],0
	pusha

extract_no:
	cmp word[num], 0
	je print_no
	inc byte[count]
	mov dx, 0
	mov ax, word[num]
	mov bx, 10
	div bx
	push dx
	mov word[num], ax
	jmp extract_no

print_no:
	cmp byte[count], 0
	je end_print
	dec byte[count]
	pop dx
	mov byte[temp], dl
	add byte[temp], 30h
	mov eax, 4
	mov ebx, 1
	mov ecx, temp
	mov edx, 1
	int 80h
	jmp print_no

end_print:
	mov eax,4
	mov ebx,1
	mov ecx,newline
	mov edx,1
	int 80h
	popa
	ret

printzero :
	mov eax,4
	mov ebx,1
	mov ecx,zero
	mov edx,1	
	int 80h
	
	mov eax,1
	int 80h
	


;Made by Pranav Prashant
;Inorder to run this program:
;Compile: nasm -f elf q4.asm
;Link: ld -melf_i386 q3.o -o q3
