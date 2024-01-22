; nasm -f macho64 execve_cmd.asm
; ld -macosx_version_min 10.14 -L /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -lSystem -o execve_cmd execve_cmd.o

BITS 64
global _main
_main:
    xor     rdx, rdx          ; zero our RDX
    push    rdx               ; push NULL string terminator
    mov     rbx, '/bin/zsh'   ; move the path into RBX
    push    rbx               ; push the path, to the stack
    mov     rdi, rsp          ; store the stack pointer in RDI
    push    "-c"              ; put -c on the stack
    mov     rbx, rsp          ; store the stack pointer in RBX
    push    rdx               ; stores NULL on the register (argv[3]=0)
    jmp     l_cmd64
r_cmd64:                      ; the call placed a pointer to db (argv[2])
    push    rbx               ; argv[1]=rbx ->"-c" 
    push    rdi               ; argv[0]=rdi ->"/bin/zsh"
    mov     rsi, rsp          ; argv=rsp - store RSP's value in RSI
    push    59                ; put 59 on the stack
    pop     rax               ; pop it to RAX
    bts     rax, 25           ; set the 25th bit to 1
    syscall
l_cmd64:
    call    r_cmd64     
    db 'touch mynewfile.txt', 0