// exh4.c: dangling pointers
//     input: none
//     output: stdout

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(void)
{
    int i;
    int *A;
    int *B;

    A = (int *)malloc(sizeof(int) * 3);
    printf("A = %x\n", (unsigned)A);
    for (i = 0; i < 3; i++)
        printf("A[%d]=%d\n", i, A[i]);

    A[0] = 10; A[1] = 20; A[2] = 30;
    for (i = 0; i < 3; i++)
        printf("A[%d]=%d\n", i, A[i]);

    free(A);
    B = (int *)malloc(sizeof(int) * 3);
    printf("B = %x\n", (unsigned)B);
    for (i = 0; i < 3; i++)
        printf("B[%d]=%d\n", i, B[i]);

    A[0] = 100; A[1] = 200; A[2] = 300;
    for (i = 0; i < 3; i++)
        printf("B[%d]=%d\n", i, B[i]);

    free(B);
    A = (int *)calloc(sizeof(int), 3);
    printf("A = %x\n", (unsigned)A);
    for (i = 0; i < 3; i++)
        printf("A[%d]=%d\n", i, A[i]);

    A[0] = 10; A[1] = 20; A[2] = 30;
    B = (int *)malloc(sizeof(int) * 3);
    A = (int *)realloc(A, sizeof(int) * 6);
    printf("A = %x\n", (unsigned)A);
    for (i = 0; i < 6; i++)
        printf("A[%d]=%d\n", i, A[i]);
    return 0;
}
