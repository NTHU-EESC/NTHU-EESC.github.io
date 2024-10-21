// exh1.c: read in a text file with char array as storage
//     input: input.txt through stdin
//     output: stdout

#include <stdio.h>
#include <stdlib.h>

char buf[35][1000];     // buffer to store all input lines,
                        //        fixed size or large size
int  Np = 0;            // number of input lines
int  iseof = 0;         // flag to indicate end of file

void readline(void);    // read a line of text from stdin

int main(void)
{
    int i;

    while (!iseof) {    // read to the end of file
        readline();
    }

    // buffer can be processed here, for example
    for (i = 0; i < Np; i++) {    // print out all lines
        printf("%s\n", buf[i]);
    }
    printf("size of data = %d\n", sizeof(buf));
    return 0;
}

void readline(void)
{
    int i;
    char ch;

    for (i = 0; (ch = getchar()) != EOF && ch != '\n'; i++)
        buf[Np][i] = ch;
    buf[Np][i] = '\0';
    if (ch == EOF) iseof = 1;
    else Np++;
}
