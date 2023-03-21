;Made by Pranav Prashant
;Inorder to run this program:
;Compile: nasm -f elf q4.asm
;Link: ld -melf_i386 q3.o -o q3


section	.data

	msg1 : db 'Enter Order of Matrix : ',10
	len1	equ	$ -msg1
	msg3 : db 'Enter Elements of Matrix : ',10
	len3 equ $ -msg3
	msg4 : db 'Matrix :',10
	len4 equ $ -msg4
	msg5 : db 'Sum of Elements of Principal Diagonal : '
	len5 equ $ -msg5
	newline : db 10
	tab : db 32
	zero : db 48

section .bss

	count : resb 1
	temp  : resb 1
	num   : resw 1
	r     : resw 1
	c     : resw 1
	i     : resw 1
	j     : resw 1
	d     : resw 1
	sum   : resw 1
	size  : resw 1
	cells : resw 1
	matrix     : resw 200
	


section .text
global _start
_start :

    mov eax,4
    mov ebx,1
    mov ecx,msg1
    mov edx,len1
    int 80h

    call read_num
    mov ax,word[num]
    mov word[r],ax
    mov word[c],ax

    mov eax,4
    mov ebx,1
    mov ecx,msg3
    mov edx,len3
    int 80h
    
    mov ax,0
    mov ebx,matrix
    mov word[i],0
    
i1_loop :
    mov word[j],0
    
j1_loop :
    call read_num
    mov dx,word[num]
    mov word[ebx + 2*eax],dx
    
    inc ax
    inc word[j]
    mov cx,word[j]
    cmp cx,word[c]
    jb j1_loop 
    
    inc word[i]
    mov cx,word[i]
    cmp cx,word[r]
    jb i1_loop
    
    mov word[cells],ax
    
    mov eax,0
    mov edx,0
    mov ecx,0
    mov ebx,matrix
    inc word[r]
    mov word[sum],0
    mov word[d],0

   
summing :
	
	mov cx,word[d]
	cmp cx,word[cells]
	ja end_sum
	
	mov ax,word[ebx + 2*edx]
	mul ax
	add word[sum],ax
	mov cx,word[r]
	add word[d],cx
	mov dx,word[d]
	jmp summing
	
	
 

    
end_sum :
    
    mov eax,4
    mov ebx,1
    mov ecx,msg4
    mov edx,len4
    int 80h
       
    dec word[r]
    mov ax,0
    mov ebx,matrix
    mov word[i],0
    
    
    
i3_loop :
    mov word[j],0
    
j3_loop :
    mov dx,word[ebx + 2*eax]
    mov word[num],dx
    call print_num
    
    pusha
    mov eax,4
    mov ebx,1
    mov ecx,tab
    mov edx,1
    int 80h
    popa
    
    inc ax
    inc word[j]
    mov cx,word[j]
    cmp cx,word[c]
    jb j3_loop
    
    pusha
    mov eax,4
    mov ebx,1
    mov ecx,newline
    mov edx,1
    int 80h
    popa
    
    inc word[i]
    mov cx,word[i]
    cmp cx,word[r]
    jb i3_loop
    
    
    mov eax,4
    mov ebx,1
    mov ecx,msg5
    mov edx,len5
    int 80h
    
    mov ax,word[sum]
    mov word[num],ax
    call print_num
    
    mov eax,4
    mov ebx,1
    mov ecx,newline
    mov edx,1
    int 80h
    

    
    mov eax,1
    mov ebx,0
    int 80h
    


read_num:

	pusha
	mov word[num], 0

loop_read:

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
	ret



print_num:
    	cmp word[num],0
	je print_zero
	mov byte[count],0
	pusha

extract_no:
	cmp word[num], 0
	je print_no
	inc byte[count]
	mov dx, 0
	mov ax, word[num]
	mov bx, 10
	div bx
	push dx
	mov word[num], ax
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

	popa
	ret
	
print_zero:

    	pusha
	mov eax, 4
	mov ebx, 1
	mov ecx, zero
	mov edx, 1
	int 80h
	popa 
    	ret
    	
    	
;Made by Pranav Prashant
;Inorder to run this program:
;Compile: nasm -f elf q4.asm
;Link: ld -melf_i386 q3.o -o q3    	
