; helloworld.asm on macOS
; nasm -f macho64 helloworld.asm
; ld -macosx_version_min 10.14 -L /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -lSystem -o helloworld helloworld.o

;; 必须在寄存器 %rax 中传递系统调用的编号：
; rdi - used to pass 1st argument to functions
; rsi - used to pass 2nd argument to functions
; rdx - used to pass 3rd argument to functions
; rcx - used to pass 4th argument to functions
; r8 - used to pass 5th argument to functions
; r9 - used to pass 6th argument to functions

;; macOS 系统调用编号：
; none	0	 Invalid
; mach	1	 Mach	
; unix	2	 Unix/BSD
; mdep 	3	 Machine-dependent
; diag	4	 Diagnostics
;; macOS 已将系统调用号分成几个不同的“类别”，系统调用号的高位代表系统调用的类，在当前例子中 wirte、exit 属于 Unix/BSD 因此高位是 2 每个 Unix 系统调用都是(0×2000000 + unix syscall)

;; 参考文章：http://dustin.schultz.io/mac-os-x-64-bit-assembly-system-calls.html
;; syscall table: https://opensource.apple.com/source/xnu/xnu-1504.3.12/bsd/kern/syscalls.master

BITS    64
global  _main

section     .text
_main:
    ; write
    mov     rax, 0x2000004
    mov     rdi, 1
    mov     rsi, str
    mov     rdx, str.len
    syscall
    ; exit
    mov     rax, 0x2000001
    xor     rdi, rdi
    syscall

section     .data
    str:    db  "Hello World"
    .len:   equ $-str
