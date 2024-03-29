;Made by Pranav Prashant
;Inorder to run this program:
;Compile: nasm -f elf q4.asm
;Link: ld -melf_i386 q3.o -o q3

section .data
  msg1: db "Architechture is Little Endian"
  size1: equ $-msg1
  msg2: db "Architechture is Big Endian"
  size2: equ $-msg2

section .bss
  temp: resb 1


section .text
  global _start

_start:

  mov eax, 0xffff0000
  push eax
  pop ax
  pop bx

  cmp bx, 0xffff
  je  LittleEndian
  
BigEndian:
  mov eax, 4
  mov ebx, 1
  mov ecx, msg2
  mov edx, size2
  int 80h
  jmp End


LittleEndian:
  mov eax, 4
  mov ebx, 1
  mov ecx, msg1
  mov edx, size1
  int 80h


End:
  mov eax, 1
  mov ebx, 0
  int 80h


;Made by Pranav Prashant
;Inorder to run this program:
;Compile: nasm -f elf q4.asm
;Link: ld -melf_i386 q3.o -o q3
