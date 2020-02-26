#include <stdio.h>

int main()
{
    char s_in[81];
    char s_out[321];

    puts("Mironchik Pavel, 8382: convert 16ns (0-9,a-h) symbols to 2ns");

    gets(s_in); 

    __asm__ (".intel_syntax noprefix\n\t"
        "mov rsi, %0\n\t"
        "mov rdi, %1\n\t"
        "cld\n"

        "TRANSFORM:"
        "mov cx,4\n\t" // set up <cx> to 0

        "lodsb\n\t"
        "cmp al,'0'\n" // check 0..9
        "jl NOT_NUMBER\n"
        "cmp al,'9'\n" 
        "jg CHECK_LOW\n"
        "sub al,'0'\n"
        "jmp TO_BIN\n"

        "CHECK_LOW:\n" // check a..f
        "cmp al,'a'\n"
        "jl NOT_NUMBER\n"
        "cmp al,'f'\n"
        "jg NOT_NUMBER\n"
        "sub al,'a'\n"
        "add al,10\n"
        "jmp TO_BIN\n"

        "TO_BIN:\n"
        "mov ah,al\n"
        "and ah,1\n"
        "add ah,'0'\n"
        "push ax\n"
        "dec cx\n"
        "shr al\n"
        "cmp cx,0\n"
        "jg TO_BIN\n"

        "mov cx,4\n"

        "WRITE:\n"
        "pop ax\n"
        "mov al,ah\n"
        "stosb\n"
        "dec cx\n"
        "cmp cx,0\n"
        "jg WRITE\n"

        "jmp TRANSFORM\n"

        "NOT_NUMBER:\n"
        "stosb\n"
        "cmp al,0\n"
        "jg TRANSFORM\n"

        : 
        : "r" (s_in), "r" (s_out)
        : "%rax","%ecx","%rsi","%rdi"
        );

    puts(s_out);
}