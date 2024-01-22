// clang -arch x86_64 simple_loader.c -o simple_loader
#include <stdio.h>
#include <sys/mman.h>
#include <string.h>
#include <stdlib.h>

int (*sc)();

// exec_calc shellcode
char shellcode[] = "\x48\x31\xc0\xb0\x02\x48\xc1\xc8\x28\xb0\x3b\x48\x31\xd2\x48\xbf\x2f\x2f\x62\x69\x6e\x2f\x73\x68\x52\x57\x54\x5f\xbb\x2d\x63\x00\x00\x52\x53\x54\x5b\x52\x48\xb9\x61\x74\x6f\x72\x2e\x61\x70\x70\x51\x48\xb9\x73\x2f\x43\x61\x6c\x63\x75\x6c\x51\x48\xb9\x6c\x69\x63\x61\x74\x69\x6f\x6e\x51\x48\xb9\x73\x74\x65\x6d\x2f\x41\x70\x70\x51\x48\xb9\x6f\x70\x65\x6e\x20\x2f\x53\x79\x51\x54\x59\x52\x51\x53\x57\x54\x5e\x0f\x05";

int main(int argc, char **argv)
{
    printf("Shellcode Length: %zd Bytes\n", strlen(shellcode));
    // start：用户进程中要映射的用户空间的起始地址，通常为NULL（由内核来指定）
    // length：要映射的内存区域的大小
    // prot：期望的内存保护标志
    // flags：指定映射对象的类型
    // fd：文件描述符（由open函数返回）
    // offset：设置在内核空间中已经分配好的的内存区域中的偏移，例如文件的偏移量，大小为PAGE_SIZE的整数倍
    // 返回值：mmap()返回被映射区的指针，该指针就是需要映射的内核空间在用户空间的虚拟地址
    void *ptr = mmap(0, 0x22, PROT_EXEC | PROT_WRITE | PROT_READ, MAP_ANON | MAP_PRIVATE, -1, 0);
    if (ptr == MAP_FAILED)
    {
        perror("mmap");
        exit(-1);
    }
    memcpy(ptr, shellcode, sizeof(shellcode));
    sc = ptr;
    sc();
    return 0;
}