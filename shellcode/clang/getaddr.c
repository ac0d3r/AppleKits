// clang -arch x86_64 -o getaddr getaddr.c
// clang -o getaddr getaddr.c
#include <unistd.h>
#include <stdio.h>
int main(void)
{
    printf("%p \n", execv);
    return 0;
}