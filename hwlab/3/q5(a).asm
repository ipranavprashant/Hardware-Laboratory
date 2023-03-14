;Made by Pranav Prashant
;Inorder to run this program:
;Compile: nasm -f elf q4.asm
;Link: ld -melf_i386 q3.o -o q3

section .data
msg1 : db 'Enter the number of elements',10
msg1L : equ $-msg1
msg2: db 'Enter the elements itself',10
msg2L : equ $-msg2
msg3 : db 'The Greatest of the entered numbers are: '
msg3L : equ $-msg3


section .bss
n1 : resw 1
n2 : resw 1
num : resw 1
sum : resw 1
count : resb 1
temp : resb 1
haha : resw 1


section .text
global _start:
_start:

mov word[sum],0
mov word[haha],0

mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,msg1L
int 80h

call read_num
mov ax,word[num]
mov word[n1],ax
mov word[n2],ax

mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,msg2L
int 80h

adding:
call read_num
call add

dec word[n1]
cmp word[n1],0
jnz adding

mov eax,4
mov ebx,1
mov ecx,msg3
mov edx,msg3L
int 80h

    mov dx,0
    mov ax,word[haha]
    mov word[num],ax

    call print_num

mov eax,1
mov ebx,0
int 80h

add:
mov ax,word[num]
cmp ax,word[haha]
jg label
ret

label:
mov word[haha],ax
ret


read_num:
pusha
mov word[num],0
loop_read:
mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h

cmp byte[temp],10
je end_read


mov ax,word[num]
mov bx,10
mul bx
mov bl,byte[temp]
sub bl,30h
mov bh,0
add ax,bx
mov word[num],ax
jmp loop_read

end_read:
popa
ret


print_num:
mov byte[count],0
pusha
extracting:
cmp word[num],0
je printing

inc byte[count]
mov ax,word[num]
mov dx,0
mov bx,10
div bx
push dx
mov word[num],ax
jmp extracting

printing:
cmp byte[count],0
je end_print

dec byte[count]
pop dx
mov byte[temp],dl
add byte[temp],30h
mov eax,4
mov ebx,1
mov ecx,temp
mov edx,1
int 80h
jmp printing

end_print:
popa
ret

;Made by Pranav Prashant
;Inorder to run this program:
;Compile: nasm -f elf q4.asm
;Link: ld -melf_i386 q3.o -o q3
