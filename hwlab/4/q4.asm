;Made by Pranav Prashant
;Inorder to run this program:
;Compile: nasm -f elf q4.asm
;Link: ld -melf_i386 q3.o -o q3

section .data
In1:db 'Enter the Sentence : '
In1n: equ $-In1
In2:db 'Enter the Word : '
In2n: equ $-In2
S1:db 'Word is NOT Present',0Ah
S1n: equ $-S1
S2:db 'Number of times the word occurs: '
S2n: equ $-S2
newline:db 10


section .bss
sentence:resb 201   ;Sentence
str2:resb 51		;Word
Res:resd 1			;For read_str
temp:resb 1
i:resd 1			;To store position in sentence while Traversal
flag:resw 1			;To count occurences [P.S : Also acts as flag (if ==0) ]
count:resb 1
num:resw 1


section .text
global _start
_start:

;Sentence Input
mov eax,4
mov ebx,1
mov ecx,In1
mov edx,In1n
int 80h
mov eax,sentence
mov dword[Res],eax
call Read_Str

;Word Input
mov eax,4
mov ebx,1
mov ecx,In2
mov edx,In2n
int 80h
mov eax,str2
mov dword[Res],eax
call Read_Str

mov word[flag],0

;Comparing
call Compare

;Setting S1 or S2 msg
cmp word[flag],0
je not_msg

;Words are Present
mov eax,4
mov ebx,1
mov ecx,S2
mov edx,S2n
int 80h

;Printing no.of occurences
mov ax,word[flag]
mov word[num],ax
call print_num
call Newline_print
jmp End_Program

not_msg:
mov eax,4
mov ebx,1
mov ecx,S1
mov edx,S1n
int 80h

End_Program:
mov eax,1
int 80h

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Newline_print:
pusha
mov eax,4
mov ebx,1
mov ecx,newline
mov edx,1
int 80h
popa
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Read_Str:
pusha
mov eax,dword[Res]
mov ebx,0
Str_loop:
call read_char
cmp byte[temp],10
je endStr_loop
mov cl,byte[temp]
mov byte[eax+ebx],cl
inc ebx
jmp Str_loop

endStr_loop:		   ;3 null characters just to be safe
mov byte[eax+ebx],0    ;3 may not be needed
inc ebx
mov byte[eax+ebx],0
inc ebx
mov byte[eax+ebx],0
popa
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
read_char:
pusha
mov eax,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h
popa
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
Compare:
pusha
mov eax,sentence
mov dword[i],eax

word_cmp:			;Going to the end of Sentence
mov ebx,dword[i]
cmp byte[ebx],0
je cmp_ret
call str_cmp		;Comparing word-by-word
jmp word_cmp

cmp_ret:
popa
ret
;--------------------------------
str_cmp:			;For comparing word 
pusha
mov ebx,str2
mov ecx,0

loop_cmp:
mov eax,dword[i]
cmp byte[ebx+ecx],0
je end_str_cmp
mov dl,byte[eax]
cmp dl,byte[ebx+ecx]
jne ret_str_cmp
inc dword[i]
inc ecx
jmp loop_cmp

end_str_cmp:
cmp byte[eax],32
je flag_imp
cmp byte[eax],0
je flag_imp

ret_str_cmp:
call move_i
popa
ret

flag_imp:			;If flag==0 at end, then not present
inc word[flag]
jmp ret_str_cmp

;------------------------------
move_i:			;For moving to next word
pusha
loop_move:
mov ebx,dword[i]
cmp byte[ebx],32
je end_move_i	  ;Moving to next word
cmp byte[ebx],0
je ret_move_i	  ;This was last word => end reached
inc dword[i]
jmp loop_move

end_move_i:
inc dword[i]

ret_move_i:
popa
ret

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
print_num:	;Normal Print_Num
pusha
mov byte[count],0
extract_no:
mov ax,word[num]
mov dx,0
mov bx,10
div bx
push dx
inc byte[count]
mov word[num],ax
cmp word[num],0
je printdig
jmp extract_no

printdig:
cmp byte[count],0
je endprint
pop dx
add dl,30h
mov byte[temp],dl
dec byte[count]
mov eax,4
mov ebx,1
mov ecx,temp
mov edx,1
int 80h
jmp printdig

endprint:		;Printing space at the end (not needed)
mov byte[temp],32
mov eax,4
mov ebx,1
mov ecx,temp
mov edx,1
int 80h
popa
ret
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;Made by Pranav Prashant
;Inorder to run this program:
;Compile: nasm -f elf q4.asm
;Link: ld -melf_i386 q3.o -o q3
