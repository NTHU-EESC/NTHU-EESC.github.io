/*
 * exh11.c: array and linked list
 *         input: exh11.in
 *         output: stdout
 */

#include <stdio.h>
#include <stdlib.h>

#define N 5               // element number in array
int A[5];                 // simple 1-D integer array

struct list {             // node for linked list
    int val;              // the value of the element
    struct list *next;    // pointer to the next element
};
struct list *B;           // now define linked list variable

int main(void)
{
    int i, j, sum, s24;
    struct list *p1, *p2, *p3;

    for (i = 0; i < N; i++)                  // array input
        scanf("%d", &A[i]);

    sum = 0;                                 // process array
    for (i = 0; i < N; i++)
        sum += A[i];
    printf("array sum=%d\n", sum);

    s24 = A[2] + A[4];                       // array accessing
    printf("array s24=%d\n", s24);

    printf("array output:\n");               // array output
    for (i = 0; i < N; i++)
        printf("%d\n", A[i]);

    B = NULL;                                // read input for linked list
    for (i = 0; i < N; i++) {
        p1 = (struct list *)malloc(sizeof(struct list));
                                             // create new node
        scanf("%d", &j);                     // read value
        (*p1).val = j;                       // store value
        (*p1).next = B;                      // pointer to the next elem
        B = p1;                              // update linked list
    }
    printf("linked list output:\n");         // output linked list
    for (p1 = B; p1 != NULL; p1 = (*p1).next) {
        printf("%d\n", (*p1).val);
    }

    sum = 0;                                 // accessing linked list
    for (p1 = B; p1 != NULL; p1 = (*p1).next) {
        sum += (*p1).val;
    }
    printf("linked list sum=%d\n", sum);

    p2 = (*B).next;                          // accessing linked list
    p2 = (*p2).next;
    s24 = (*B).val + (*p2).val;
    printf("linked list s24=%d\n", s24);

    p2 = NULL;                               // reversing a linked list
    for (p1 = B; p1 != NULL; ) {
        p3 = (*p1).next;                     // save next ptr to p3
        (*p1).next = p2;                     // update next ptr
        p2 = p1;                             // current head of linked list
        p1 = p3;                             // old next ptr
    }
    B = p2;

    printf("after reversing linked list\n");     // output linked list
    for (p1 = B; p1 != NULL; p1 = (*p1).next) {
        printf("%d\n", (*p1).val);
    }

    B = NULL;             // creating the linked list in the right order
    for (i = 0; i < N; i++) {
        p1 = (struct list *)malloc(sizeof(struct list));
                                                 // allocating node
        scanf("%d", &j);                         // read value
        (*p1).val = j;                           // assign value
        (*p1).next = NULL;                       // next -> NULL
        if (B == NULL) B = p1;                   // update linked list
        else (*p2).next = p1;
        p2 = p1;
    }

    printf("reading in-order linked list\n");    // output linked list
    for (p1 = B; p1 != NULL; p1 = (*p1).next) {
        printf("%d\n", (*p1).val);
    }
}
