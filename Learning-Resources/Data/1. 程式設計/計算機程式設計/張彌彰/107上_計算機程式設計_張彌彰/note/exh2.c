/*
 * exh2.c: read in a text file with malloc
 *     input: input.txt through stdin
 *     output: stdout
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *buf[35];           // buffer to store all input lines
                         // smaller size and can be grown as needed
int  Np = 0;             // number of input lines
int  iseof = 0;

void readline(void);     // read one line of text from stdin

int main(void)
{
    int i,j,k;

    while (!iseof) {     // read one line at a time
        readline();
    }

    // text can be processed here, for example
    for (i = 0; i < Np; i++) {        // print out all text
        printf("%s\n", buf[i]);
    }

    printf("size of data = %d bytes\n",
        &buf[Np - 1][strlen(buf[Np - 1])] - &buf[0][0]);
}

void readline(void)
{
    char line[1000];             // input line read in here
    int i;
    char ch;

    for (i = 0; (ch = getchar()) != EOF && ch != '\n'; i++) {
        line[i] = ch;
    }
    line[i] = '\0';

    if (ch == EOF) iseof = 1;
    else {
        // use dynamic memory allocation for needed memory
        buf[Np] = (char *)malloc(sizeof(char) * (i + 1));
        strcpy(buf[Np], line);
        Np++;
    }
}
