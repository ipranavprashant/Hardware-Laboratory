
;Made by Pranav Prashant
;Inorder to run this program:
;Compile: nasm -f elf q4.asm
;Link: ld -melf_i386 q3.o -o q3

section .data
       msg1: db "Enter first number",10
         l1:  equ $-msg1

       msg2: db "Enter second number", 10
         l2: equ $-msg2

       msg3: db "YES"
         l3: equ $-msg3

       msg4: db "NO"
         l4: equ $-msg4

     newline: db 10
        tab: db 9

section .bss
  n1: resd 1
  n2: resd 1
 temp: resd 1
counter: resd 1
  jr: resd 1

section .text
      global _start:
_start:
   
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, l1
    int 80h

    call read_num
   mov eax, dword[jr]
   mov dword[n1], eax

   mov eax ,4
   mov ebx ,1
   mov ecx, msg2
   mov edx, l2
   int 80h

   call read_num
   mov eax, dword[jr]
   mov dword[n2], eax

   mov eax, dword[n1]
   cmp eax, dword[n2]
   jb label1
   mov ebx, dword[n2]
   mov edx, 0
   div ebx
   cmp edx, 0
   jne end
   mov eax, 4
   mov ebx, 1
   mov ecx, msg3
   mov edx, l3
   int 80h
   jmp exit
  
  label1:
      mov eax, dword[n2]
      mov ebx, dword[n1]
      mov edx, 0
      div ebx
      cmp edx, 0
      jne end
      mov eax, 4
      mov ebx, 1
      mov ecx, msg3
      mov edx, l3
      int 80h
      jmp exit

end:
   mov eax, 4
   mov ebx, 1
   mov ecx, msg4
   mov edx, l4
   int 80h
   jmp exit

exit:
    mov eax, 1
    mov ebx ,0
    int 80h

read_num:

pusha
mov dword[jr],0
reading:
   mov eax,3
   mov ebx,0
   mov ecx,temp
   mov edx,1
   int 80h

   cmp dword[temp],10
   je end_read
sub dword[temp],30h
mov eax,dword[jr]
mov edx,0
mov ebx,10
mul ebx
add eax,dword[temp]
mov dword[jr],eax
jmp reading

end_read:

popa
ret

;Made by Pranav Prashant
;Inorder to run this program:
;Compile: nasm -f elf q4.asm
;Link: ld -melf_i386 q3.o -o q3










































































































































;Made by Pranav Prashant
;Inorder to run this program:
;Compile: nasm -f elf q4.asm
;Link: ld -melf_i386 q3.o -o q3



