;Type the following command in the terminal
;nasm -f elf64 func.asm -o func.o && gcc func.o copy_file.c -static  -o exe64 && ./exe64

SYS_OPEN equ 5
SYS_WRITE equ 4
READ_ONLY equ 0
SYS_READ equ 3
STDID equ 0
STDOUT equ 1
END_OF_FILE equ 0x23


section .data
    filename db "save.txt", 0
    filename_len equ $-filename
    fd dq 0

global save_out
 
section .text

save_out:
	mov	r10, rdi
	mov	r11, rsi

    push r10
    push r11

	mov rdi, filename
    mov rsi, 0102h     ;O_CREAT, man open
    mov rdx, 0666h     ;umode_t
    mov rax, 2
    syscall

    pop r11
    pop r10

    mov [fd], rax
    mov rdx, r11       ;message length
    mov rsi, r10       ;message to write
    mov rdi, [fd]      ;file descriptor
    mov rax, 1         ;system call number (sys_write)
    syscall            ;call kernel

    mov rdi, [fd]
    mov rax, 3         ;sys_close
    syscall


	ret
