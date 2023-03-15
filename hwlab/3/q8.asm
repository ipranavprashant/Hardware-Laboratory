;Made by Pranav Prashant
;Inorder to run this program:
;Compile: nasm -f elf q4.asm
;Link: ld -melf_i386 q3.o -o q3

section .data
  msg1: db "Enter the string : "
  size1: equ $-msg1
  msg2: db "Enter the second string : "
  size2: equ $-msg2
  msg3: db "The concatenated string is : "
  size3: equ $-msg3
  msg4: db 10
  size4: equ $-msg4

section .bss
  string1: resb 50
  string2: resb 50
  temp: resb 1
  len1: resb 1
  len2: resb 1
  j: resb 1
  i: resb 1
  d0: resb 1
  d1: resb 1


section .text
  global _start

_start:
  
  mov eax, 4
  mov ebx, 1
  mov ecx, msg1
  mov edx, size1
  int 80h

  mov ebx, string1
  mov byte[len1], 0

reading1:
  push ebx

  mov eax, 3
  mov ebx, 0
  mov ecx, temp
  mov edx, 1
  int 80h
  
  pop ebx
  mov al, byte[temp]
  mov byte[ebx], al
  
  inc byte[len1]
  inc ebx

  ;NASM change the ascii code of enter 13 to 10
  cmp byte[temp], 10
  jne reading1


endreading1:
  dec ebx
  mov byte[ebx],0
  dec byte[len1]


  mov eax, 4
  mov ebx, 1
  mov ecx, msg2
  mov edx, size2
  int 80h

  mov ebx, string2
  mov byte[len2], 0

reading2:
  push ebx

  mov eax, 3
  mov ebx, 0
  mov ecx, temp
  mov edx, 1
  int 80h
  
  pop ebx
  mov al, byte[temp]
  mov byte[ebx], al
  
  inc byte[len2]
  inc ebx

  ;NASM change the ascii code of enter 13 to 10
  cmp byte[temp], 10
  jne reading2


endreading2:
  dec ebx
  mov byte[ebx],0
  dec byte[len2]
  

;Printing the string....


  mov eax, 4
  mov ebx, 1
  mov ecx, msg3
  mov edx, size3
  int 80h

  

  mov eax, 4
  mov ebx, 1
  mov ecx, string1
  movzx edx, byte[len1]
  int 80h

  mov eax, 4
  mov ebx, 1
  mov ecx, string2
  movzx edx, byte[len2]
  int 80h

 mov eax, 4
  mov ebx, 1
  mov ecx, msg4
  mov edx, size4
  int 80h
  
  
exit:
  mov eax, 1
  mov ebx, 0
  int 80h
  
  
;Made by Pranav Prashant
;Inorder to run this program:
;Compile: nasm -f elf q4.asm
;Link: ld -melf_i386 q3.o -o q3  
