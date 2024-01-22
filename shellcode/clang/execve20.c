// clang -arch x86_64 -shared -fno-stack-protector -o execve20 execve20.c
// objdump -d --x86-asm-syntax=intel --print-imm-hex execve20
int main(void)
{
    typedef int *(*execv_t)(const char *, char *const *);
    execv_t my_execv = (execv_t)0x7ff805723df7;
    char s[9];
    s[0] = '/';
    s[1] = 'b';
    s[2] = 'i';
    s[3] = 'n';
    s[4] = '/';
    s[5] = 'z';
    s[6] = 's';
    s[7] = 'h';
    s[8] = 0;
    my_execv(s, 0);
}