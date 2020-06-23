%include "functions.asm"


section .bss
    sum resq 1

section	.text
    global _start
	
_start:
    mov dword [sum], 0

    mov eax, 0
    jmp loop1
    
    content_loop1:
    mov ebx, 0
    jmp loop2
   
    content_loop2:
    mov ecx, 0
    jmp loop3

    content_loop3:
    mov edx, 0
    jmp loop4

    content_loop4:

    add dword[sum], eax
    add dword[sum], ebx
    add dword[sum], ecx
    add dword[sum], edx

    add edx, 1
    loop4:
    cmp edx, 6
    jne content_loop4

    add ecx, 1
    loop3:
    cmp ecx, 5
    jne content_loop3

    add ebx, 1
    loop2:
    cmp ebx, 4
    jne content_loop2
    
    add eax, 1
    loop1:
    cmp eax, 3
    jnz content_loop1
    

    mov eax, dword[sum]
    call iprintLF

    call quit
     
