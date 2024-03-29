;Made by Pranav Prashant
;Inorder to run this program:
;Compile: nasm -f elf q4.asm
;Link: ld -melf_i386 q3.o -o q3

section .data
tab: db 9
newline: db 10
msg1: db 'Matrix1:',10
l1: equ $-msg1
msg2: db 'Matrix2:',10
l2: equ $-msg2
row: db 'Enter # of ROWS:',10
r: equ $-row
col: db 'Enter # of COLUMNS:',10
c: equ $-col
summatrix: db 'Sum of Two Matrices:',10
sm: equ $-summatrix


section .bss
just_read: resd 1
just_print: resd 1
temp: resd 1
counter: resd 1
zero: resd 1
m: resd 1
n: resd 1
arr1: resd 50
arr2: resd 50
i: resd 1
j: resd 1
var: resd 1


section .text
global _start:
_start:

mov eax,4
mov ebx,1
mov ecx,row
mov edx,r
int 80h
call read_num
mov eax,dword[just_read]
mov dword[m],eax


mov eax,4
mov ebx,1
mov ecx,col
mov edx,c
int 80h
call read_num
mov eax,dword[just_read]
mov dword[n],eax

mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,l1
int 80h
mov ebx,arr1
mov eax,0
mov dword[i],0
call read_2Darray


mov eax,4
mov ebx,1
mov ecx,msg2
mov edx,l2
int 80h
mov ebx,arr2
mov eax,0
mov dword[i],0
call read_2Darray

mov eax,4
mov ebx,1
mov ecx,summatrix
mov edx,sm
int 80h
sum_matrix:

mov eax,0
mov dword[var],eax
mov dword[i],0
i_loop:
mov dword[j],0
j_loop:
mov eax,dword[var]
mov ebx,arr1
mov ecx,arr2
mov edx,dword[ebx+(4*eax)]
add edx,dword[ecx+(4*eax)]
mov dword[just_print],edx
call print_num
inc dword[var]
inc dword[j]
mov edx,dword[j]
cmp edx,dword[n]
jb j_loop
inc dword[i]
mov eax,4
mov ebx,1
mov ecx,newline
mov edx,1
int 80h
mov edx,dword[i]
cmp edx,dword[m]
jb i_loop

end:
mov eax,1
mov ebx,0
int 80h

read_2Darray:

pusha

row_loop1:
mov dword[j],0

col_loop1:
call read_num
mov ecx,dword[just_read]
mov dword[ebx+(4*eax)],ecx
inc eax
inc dword[j]
mov ecx,dword[j]
cmp ecx,dword[n]
jb col_loop1
inc dword[i]
mov ecx,dword[i]
cmp ecx,dword[m]
jb row_loop1

end_read_2Darray:

popa
ret

print_2Darray:

pusha
mov dword[i],0

row_loop2:
mov dword[j],0

col_loop2:
mov ecx,dword[ebx+(4*eax)]
mov dword[just_print],ecx
call print_num

pusha
mov eax,4
mov ebx,1
mov ecx,tab
mov edx,1
int 80h
popa

inc eax
inc dword[j]
mov ecx,dword[j]
cmp ecx,dword[n]
jb col_loop2

pusha 
mov eax,4
mov ebx,1
mov ecx,newline
mov edx,1
int 80h
popa

inc dword[i]
mov ecx,dword[i]
cmp ecx,dword[m]
jb row_loop2

end_print_2Darray:

popa
ret

read_num:

pusha
mov dword[just_read],0
reading:
mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h

cmp dword[temp],10
je end_read
sub dword[temp],30h
mov eax,dword[just_read]
mov edx,0
mov ebx,10
mul ebx
add eax,dword[temp]
mov dword[just_read],eax
jmp reading

end_read:

popa
ret

print_num:

pusha
mov dword[counter],0
cmp dword[just_print],0
jne extracting
mov dword[zero],30h
mov eax,4
mov ebx,1
mov ecx,zero
mov edx,1
int 80h
jmp end_print

extracting:

cmp dword[just_print],0
je printing
mov eax,dword[just_print]
mov edx,0
mov ebx,10
div ebx
push edx
mov dword[just_print],eax
inc dword[counter]
jmp extracting

printing:

cmp dword[counter],0
je end_print
pop edx
add edx,30h
mov dword[temp],edx
mov eax,4
mov ebx,1
mov ecx,temp
mov edx,1
int 80h
dec dword[counter]
jmp printing

end_print:
mov eax,4
mov ebx,1
mov ecx,tab
mov edx,1
int 80h

popa
ret

;Made by Pranav Prashant
;Inorder to run this program:
;Compile: nasm -f elf q4.asm
;Link: ld -melf_i386 q3.o -o q3
