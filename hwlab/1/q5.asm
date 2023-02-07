;Made by Pranav Prashant
;Inorder to run this program:
;Compile: nasm -f elf q4.asm
;Link: ld -melf_i386 q3.o -o q3

section .text
global _start:
_start:
read_num:

pusha

mov word[num], 0
loop_read:
;; read a digit
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

mov word[var1],0
mov word[var2],0

loop:
mov ax,word[num]
cmp word[var1],ax
je eloop
mov ax,0
inc word[var1]
read_num1:

pusha

mov word[num1], 0
loop_read1:
;; read a digit
mov eax, 3
mov ebx, 0
mov ecx, temp
mov edx, 1
int 80h

cmp byte[temp], 10
je end_read1
mov ax,0
mov ax, word[num1]
mov bx, 10
mul bx
mov bl, byte[temp]
sub bl, 30h
mov bh, 0
add ax, bx

mov word[num1], ax
jmp loop_read1
end_read1:
mov bx,0
popa
mov bx,word[var2]
cmp word[num1],bx
ja change
jmp loop
change:
mov bx,0
mov bx,word[num1]
mov word[var2],bx
jmp loop

eloop:

print_num:
mov byte[count],0
pusha
extract_no:
cmp word[var2], 0
je print_no
inc byte[count]
mov dx, 0
mov ax, word[var2]
mov bx, 10
div bx
push dx
mov word[var2], ax
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
mov ecx,nl
mov edx,1
int 80h
popa

exit:
mov eax,1
mov ebx,0
int 80h

section .data
nl: db 10

section .bss
count: resb 10
temp: resb 10
var1: resw 10
num: resw 10
var2: resw 10
num1: resw 10


;Made by Pranav Prashant
;Inorder to run this program:
;Compile: nasm -f elf q4.asm
;Link: ld -melf_i386 q3.o -o q3
