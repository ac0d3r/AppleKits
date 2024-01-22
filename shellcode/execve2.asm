; nasm -f macho64 execve2.asm
; ld -macosx_version_min 10.14 -L /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -lSystem -o execve2 execve2.o 

BITS    64
global  _main

section     .text
_main:
    ; execve("/bin/zsh", 0, 0)
    xor     rax, rax        ; rax = 0
    mov     al, 0x2         ; rax = 0x2
    ror     rax, 0x28       ; 左移 rax = 0x2000000
    mov     al, 0x3b        ; rax=execve

    xor     rdx, rdx        ; rdx=0
    xor     rsi, rsi        ; rsi = 0

    push    rdx
    mov     rdi, '/bin/zsh'
    push    rdx
    push    rdi
    push    rsp
    pop     rdi             ; rdi = '/bin/zsh'

    syscall                 ; rax=execve rdi='/bin/zsh' rsi=0 rdx=0