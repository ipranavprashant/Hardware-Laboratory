section .data
    msg1:db 'Enter the number of elements:',0xA
    len1: equ $-msg1
    msg2: db 'Enter the numbers:',0xA
    len2: equ $-msg2
    msg: db 'The mean of the n numbers is: '
    len: equ $-msg
section .bss
    num resw 1
    n resw 1
    t resw 1
    temp resb 1
    count resb 1
    sum resw 1

section .text
    global _start
    _start:

    mov word[sum],0

    mov eax,4
    mov ebx,1
    mov ecx,msg1
    mov edx,len1
    int 80h

    call read_num
    mov ax,word[num]
    mov word[n],ax
    mov word[t],ax

    mov eax,4
    mov ebx,1
    mov ecx,msg2
    mov edx,len2
    int 80h

    read_and_add:
    
    call read_num

    call add

    dec word[n]
    cmp word[n],0
    jnz read_and_add

    mov eax,4
    mov ebx,1
    mov ecx,msg
    mov edx,len
    int 80h

    mov dx,0
    mov ax,word[sum]
    mov bx,word[t]
    div bx
    mov word[num],ax

    call print_num

    mov eax,1
    mov ebx,0
    int 80h

add:
    mov ax,word[num]
    add word[sum],ax
    ret

print_num:
    mov byte[count],0
    pusha
    extract_no:
    cmp word[num],0
    je print_no
    inc byte[count]
    mov dx,0
    mov ax,word[num]
    mov bx,10
    div bx
    push dx
    mov word[num],ax
    jmp extract_no
    print_no:
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
    jmp print_no
    end_print:
    mov eax,4
    mov ebx,1
    mov ecx,10
    mov edx,1
    int 80h
    popa
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
