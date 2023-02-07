section .data
n1 : db "Enter an integer", 10
ln1 : equ $-n1

ys : db "Yes first number is a multiple of second"
lys : equ $-ys
no : db "No first number is not a multiple of second"
lno : equ $-no

section .bss
i : resb 4
x : resb 2
y : resb 4
c : resb 1
prev : resb 1
section .text
global _start:
    _start:
    mov eax,4 
    mov ebx,1
    mov ecx,n1
    mov edx,ln1
    int 80h

    mov eax,3
    mov ebx,0
    mov ecx,x
    mov edx,2
    int 80h

    mov eax,4 
    mov ebx,1
    mov ecx,n1
    mov edx,ln1
    int 80h

    mov eax,3 
    mov ebx,0
    mov ecx,i
    mov edx,1
    int 80h

    mov eax,3
    mov ebx,0
    mov ecx,y
    mov edx,4
    int 80h

    mov eax, 0
    mov ecx, 0

    sub byte[x], 30h
    sub byte[x+1], 30h

    movzx eax, byte[x]
    mov ebx, 10
    mul ebx

    mov ecx, eax
    add ecx, [x+1]

    mov [x], cx 

    mov eax,0
    mov ecx,0

    sub byte[y], 30h
    sub byte[y+1], 30h
    sub byte[y+2], 30h
    sub byte[y+3], 30h

    movzx eax, byte[y]
    mov ebx, 1000
    mul ebx

    mov ecx, eax

    movzx eax, byte[y+1]
    mov ebx, 100
    mul ebx

    add ecx, eax

    movzx eax, byte[y+2]
    mov ebx, 10
    mul ebx

    add ecx, eax

    add ecx, [y+3]

    mov [y], ecx

    mov ax, [y]
    mov cl, [x]
    div cl

    cmp ah, 0
    jne nn
    
    mov eax, 4
    mov ebx, 1
    mov ecx, ys
    mov edx, lys
    int 80h

    jmp exit

    nn: 
    mov eax,4
    mov ebx,1
    mov ecx,no
    mov edx,lno
    int 80h

    jmp exit

    exit:
    mov eax, 1
    mov ebx, 0
    int 80h
    

    
