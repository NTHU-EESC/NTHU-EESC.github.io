/*
 * exh3.c: read in a text file with malloc and realloc
 *     input: input.txt through stdin
 *     output: stdout
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char **buf;             // buffer to store all input lines
                        // smaller size and can be grown as needed
int  Np = 0;            // number of input lines
int  iseof = 0;
int  Nb = 5;            // size of buf

void readline(void);    // read one line of text from stdin

int main(void)
{
    int i,j,k;

    buf = (char **)malloc(sizeof(char *) * Nb);
    while (!iseof) {    // read one line at a time
        readline();
        if (Np == Nb) {
            Nb += 5;
            buf = (char **)realloc(buf, sizeof(char *) * Nb);
        }
    }

    // text can be processed here, for example
    k = 0;
    for (i = 0; i < Np; i++) {        // print out all text
        printf("%s\n", buf[i]);
        k += strlen(buf[i]);
    }
    printf("Number of bytes taken by text = %d\n",k);
/*
    // the following is no longer accurate
    printf("size of data = %d bytes\n",
        &buf[Np - 1][strlen(buf[Np - 1])] - &buf[0][0]);
*/
}

void readline(void)
{
    char line[1000];    // input line read in here
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
