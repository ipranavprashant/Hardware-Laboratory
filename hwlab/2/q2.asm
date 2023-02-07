;Made by Pranav Prashant
;Inorder to run this program:
;Compile: nasm -f elf q4.asm
;Link: ld -melf_i386 q3.o -o q3

section .data
msg1:db 'Enter the number',0Ah
l1:equ $-msg1
msg2:db 'Square of given number is:'
l2:equ $-msg2
newline: db 10

section .bss
n:resw 1
s:resw 1
d:resb 1
t:resb 1
temp:resw 1

section .text
global _start:
_start:

mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,l1
int 80h

call read_num
mov ax,word[temp]
mov word[n],ax

;call print_num1

call cal_sqr

mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,l2
int 80h

call print_num

mov eax,1
mov ebx,0
int 80h

read_num:
pusha
mov word[temp],0

loop_read:
mov eax,3
mov ebx,0
mov ecx,d
mov edx,1
int 80h
cmp byte[d],10
je end_read
sub byte[d],30h
mov ax,word[temp]
mov bx,10
mul bx
mov bl,byte[d]
mov bh,0
add ax,bx
mov word[temp],ax
jmp loop_read
end_read:
popa
ret

cal_sqr:
pusha
mov ax,word[n]
mov bx,word[n]
mul bx
mov word[s],ax
popa
ret

print_num:
pusha
mov byte[d],0

extract_no:
cmp word[s],0
je print_no
inc byte[d]
mov dx,0
mov ax,word[s]
mov bx,10
div bx
push dx
mov word[s],ax
jmp extract_no

print_no:
cmp byte[d],0
je end_print
dec byte[d]
pop dx
mov byte[t],dl
add byte[t],30h
mov eax,4
mov ebx,1
mov ecx,t
mov edx,1
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


;Made by Pranav Prashant
;Inorder to run this program:
;Compile: nasm -f elf q4.asm
;Link: ld -melf_i386 q3.o -o q3
