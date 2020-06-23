;Type the following command in the linux teiminal:
;nasm -f elf compare_diff.asm && ld -m elf_i386 compare_diff.o -o exe

%include 	'functions.asm'

SYS_OPEN equ 5
SYS_WRITE equ 4
READ_ONLY equ 0
SYS_READ equ 3
STDID equ 0
STDOUT equ 1
END_OF_FILE equ 0x23


section .data
    NEXT_LINE db 0xA
    READ_LEN equ 50000
    file2 db "files/file2.txt", 0 ; there must be 0 in the end!!!
    file1 db "files/file1.txt", 0
    
section .bss
    handler resd 5
    buf1 resb READ_LEN
    buf2 resb READ_LEN


section .text
 global _start


_start:
    
    call read_file1
    call read_file2

    call compare_line

    call quit


compare_line:
    mov eax, buf1
    mov ebx, buf2
    mov dl, 0 ; dl is the line counter register

    new_line:
    inc dl ; new line, counter inc
    
    curr_line:
    mov cl, byte [eax]
    mov ch, byte [ebx]

    cmp cl, END_OF_FILE
    jz quit_place

    cmp ch, END_OF_FILE
    jz quit_place

    cmp cl, ch
    jne line_not_equal

    cmp cl, 0xA 
    jne continue_curr_line
    
    jmp continue_new_line

    
    line_not_equal:
    
    push eax
    movzx eax, dl
    call iprintLF
    pop eax

    call mov2lf1
    call mov2lf2
    jmp continue_new_line

    continue_curr_line:
    inc eax
    inc ebx
    jmp curr_line

    continue_new_line:
    inc eax
    inc ebx
    jmp new_line
    

    quit_place:
    call quit

    ret


mov2lf1:
    loop_lf1:
    cmp byte [eax], 0xA
    jne next_lf1

    ret

    next_lf1:
    inc eax
    jmp loop_lf1
    

mov2lf2:
    loop_lf2:
    cmp byte [ebx], 0xA
    jne next_lf2

    ret

    next_lf2:
    inc ebx
    jmp loop_lf2
 

read_file1:
    ; open file first and get the handler
    mov eax, SYS_OPEN ; system call
    mov ebx, file1 ; filename
    mov ecx, READ_ONLY ; open mode
    mov edx, 0777 ; 0777 permission
    int 80h

    mov [handler], eax

    ; read file from handler
    mov eax, SYS_READ
    mov ebx, [handler] 
    mov ecx, buf1
    mov edx, READ_LEN
    int 80h

    ; close the file
    mov eax, 6
    mov ebx, [handler]
    int 80h
    
    ret

read_file2:
    ; open file
    mov eax, SYS_OPEN
    mov ebx, file2
    mov ecx, READ_ONLY
    mov edx, 0777
    int 80h

    mov [handler], eax

    ; read file from handler
    mov eax, SYS_READ
    mov ebx, [handler]
    mov ecx, buf2
    mov edx, READ_LEN
    int 80h

    ; close the file
    mov eax, 6
    mov ebx, [handler]
    int 80h
    
    ret


print:
    mov eax, SYS_WRITE
    mov ebx, STDOUT
    int 80h
    ret



