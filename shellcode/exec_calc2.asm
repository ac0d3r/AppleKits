; nasm -f macho64 exec_calc2.asm
; ld -macosx_version_min 10.14 -L /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -lSystem -o exec_calc2 exec_calc2.o

BITS        64
global      _main

section     .text
_main:
    xor     rax, rax
    mov     al, 0x2         ; rax=0x2
    ror     rax, 0x28       ; 左移 rax=0x2000000
    mov     al, 0x3b        ; rax=execve
    
    xor     rdx, rdx        ; rdx=0

    push    rdx
    mov     rdi, '/bin/zsh'
    push    rdx
    push    rdi
    push    rsp
    pop     rdi             ; rdi='/bin/zsh'

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
    pop     rsi             ; rsi=['/bin/zsh', '-c', 'open /System/Applications/Calculator.app']
    
    syscall                 ; rax=execve rdi='/bin/zsh' rsi=['/bin/zsh', '-c', 'open /System/Applications/Calculator.app'] rdx=0