// clang -arch x86_64 -shared -fno-stack-protector -o execve2 execve2.c
// objdump -d --x86-asm-syntax=intel --print-imm-hex execve2
#include <unistd.h>
int main(void)
{
    char *cmd[] = {"/bin/zsh", "-c", "open /System/Applications/Calculator.app", NULL};
    execv(cmd[0], cmd);
    return 0;
}