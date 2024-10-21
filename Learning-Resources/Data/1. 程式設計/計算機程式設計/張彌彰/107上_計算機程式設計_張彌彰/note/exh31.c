/*
 * exh31.c: read in a text file with malloc
 *     handle very long lines
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

    while (!iseof) {              // read one line at a time
        readline();
    }

    // text can be processed here, for example
    for (i = 0; i < Np; i++) {        // print out all text
        printf("%s\n", buf[i]);
    }
}

void readline(void)
{
    char *line = NULL;      // input line is also dynamically allocated
    int i, len = 30;
    char ch;

    if (line == NULL) line = (char *)malloc(len);
    for (i = 0; (ch = getchar()) != EOF && ch != '\n'; i++) {
        if (i == len) {                          // long line
            len += 30;                           // increase line length
            line = (char *)realloc(line, len);   // get more memory space
        }
        line[i] = ch;
    }
    line[i] = '\0';
    if (ch == EOF) {
        free(line);
        iseof = 1;
    }
    else buf[Np++] = line;
}
