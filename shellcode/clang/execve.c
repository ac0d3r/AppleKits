// -shared 共享(位置无关)
// -fno-stack-protector 禁用堆栈保护器的使用
// clang -arch x86_64 -shared -fno-stack-protector -o execve.a execve.c
int main()
{
    char *args[3];
    // clang 我没有找到哪个编译参数 不要处理 string 或 char* 把数据添加 Section __cstring 下
    // -fno-constant-cfstrings -fno-data-sections -fno-stack-size-section 编译参数均没啥用
    char s[8];
    s[0] = '/';
    s[1] = 'b';
    s[2] = 'i';
    s[3] = 'n';
    s[4] = '/';
    s[5] = 's';
    s[6] = 'h';
    s[7] = 0;
    args[0] = s;
    args[1] = 0;
    args[2] = 0;
    long long int ret = 0;
    int y = 0x200003b;
    asm("movq  %4,%%rax;"
        "movq %1,%%rdi;"
        "mov %2,%%rsi;"
        "mov %3,%%rdx;"
        "syscall"
        : "=g"(ret)
        : "g"(args[0]), "g"(args[1]), "g"(args[2]), "g"(y));
    return ret;
}
