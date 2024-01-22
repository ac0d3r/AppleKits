; nasm -f macho64 helloworld2.asm
; ld -macosx_version_min 10.14 -L /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -lSystem -o helloworld2 helloworld2.o
BITS    64
global  _main

section     .text
_main:
    mov     rax, 0x2000004  ;write
    mov     rdi, 1          ;stdout
    mov     rbx, 'hi'
    push    rbx
    mov     rsi, rsp
    mov     rdx, 2
    syscall
    mov     rax, 0x2000001  ;exit
    xor     rdi, rdi        ;0
    syscall