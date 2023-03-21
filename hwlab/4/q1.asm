;Made by Pranav Prashant
;Inorder to run this program:
;Compile: nasm -f elf q4.asm
;Link: ld -melf_i386 q3.o -o q3

section .data

	str1 : db 'Enter Size of First Array :  '
	len1 equ $ -str1
	str2 : db 'Enter Elements of First Array :',10
	len2 equ $ -str2
	str3 : db 'Enter Size of Second Array : '
	len3 equ $ -str3
	str4 : db 'Enter Elements of Second Array :',10
	len4 equ $ -str4
	str5 : db 'Combined Sorted Array : ',10
	len5 equ $ -str5
	zero : db 48
	space : db ' '
	newline : db 10
	
section .bss
	
	count  : resb 1
	temp   : resb 1
	num    : resw 1
	size   : resw 1
	array1 : resw 50
	array2 : resw 50
	array3 : resw 50
	n      : resw 1
	m      : resw 1
	i      : resw 1
	j      : resw 1
	k      : resw 1
	total  : resw 1
	
section .text
global _start
_start :

	mov eax, 4
	mov ebx, 1
	mov ecx, str1
	mov edx, len1
	int 80h
	
	call read_num
	mov ax,word[num]
	mov word[n],ax
	mov word[size],ax
	mov eax, 4
	mov ebx, 1
	mov ecx, str2
	mov edx, len2
	int 80h
	mov eax, 0
	mov ebx, array1
	call read_array
	
	
	mov eax, 4
	mov ebx, 1
	mov ecx, str3
	mov edx, len3
	int 80h
	
	call read_num
	mov ax,word[num]
	mov word[m],ax
	mov word[size],ax
	mov eax, 0
	mov ebx, array2
	call read_array
	
	
	
	
	mov word[i],0
	mov word[j],0
	mov word[k],0
	mov ax,0
	mov ax,word[n]
	add ax,word[m]
	dec ax
	mov word[total],ax
	mov ebx,array1
	
	
merge : 
	
	mov eax,0
	mov ecx,0
	mov ax,word[i]
	mov cx,word[j]
	
	
	
	mov edx,array2
	mov ax,word[edx + 2*ecx]
	
	
	
	
	cmp word[ebx],ax
	jb insert1
	
	jmp insert2
	
	

insert1 :

	
	mov ax,word[ebx]
	mov word[num],ax
	call print_num
	inc word[k]
	
	mov edx,0
	mov dx,word[k]
	cmp dx,word[total]
	ja end_array
	mov ax,word[i]
	cmp ax,word[n]
	jb inci
back1  :

	jmp merge
	
	
insert2 :
	
	mov edx,0
	mov eax,array2
	mov dx,word[j]
	
	mov cx,word[eax + 2*edx]
	
	
	mov word[num],cx
	
	call print_num
	inc word[k]
	mov edx,0
	mov dx,word[k]
	cmp dx,word[total]
	ja end_array
	mov ax,word[j]
	cmp ax,word[m]
	jb incj
back2  :
	jmp merge
	
inci :

	inc word[i]
	mov eax,0
	mov ax,word[n]
	cmp word[i],ax
	je print2
	add ebx,2
	jmp back1
	
	
incj :

	inc word[j] 
	mov eax,0
	mov ax,word[m]
	cmp word[j],ax
	je print1
	jmp back2
	
print2:
	mov eax,array2
	mov edx,0
	mov dx,word[j]
	cmp dx,word[m]
	je end_array
	mov cx,word[eax + 2*edx]
	mov word[num],cx
	call print_num
	inc word[j]
	jmp print2
	
print1:
	mov eax,array1
	mov edx,0
	mov dx,word[i]
	cmp dx,word[n]
	je end_array
	mov cx,word[eax + 2*edx]
	mov word[num],cx
	call print_num
	inc word[i]
	jmp print1
	
end_array :

	
	jmp exit
	
	
	
	
	
exit :	
	mov eax, 1
	mov ebx, 0
	int 80h

	


read_array:

	read_loop:
	cmp ax,word[size]
	je read_end
	call read_num
	mov cx,word[num]
	mov word[ebx+2*eax],cx
	inc eax
	jmp read_array

read_end:
	ret
	
	
print_array :
	
	pusha
	mov ax,0
	
print_loop :

	cmp ax,word[size]
	je print_end
	mov cx,word[ebx + 2*eax]
	mov word[num],cx
	call print_num
	inc ax
	jmp print_loop
	
print_end :

	popa 
	ret





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
	mov eax, 4
	mov ebx, 1
	mov ecx, space
	mov edx, 1
	int 80h
	popa
	ret
	
print_zero:
	mov eax, 4
	mov ebx, 1
	mov ecx, space
	mov edx, 1
	int 80h
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
