/*
 * exh12.c: linked list with -> operator
 *         input: exh11.in
 *         output: stdout
 */

#include <stdio.h>
#include <stdlib.h>

#define N 5               // number of elements in array

struct list {             // define a node
    int val;              // the value of the element
    struct list *next;    // pointer to the next element
};

struct list *B;           // now define linked list variable

int main(void)
{
    int i, j, sum, s24;
    struct list *p1, *p2, *p3;

    // read input for linked list
    B = NULL;
    for (i = 0; i < N; i++) {
        p1 = (struct list *)malloc(sizeof(struct list));
        scanf("%d", &j);
//      (*p1).val = j;
//      (*p1).next = B;
        p1->val = j;
        p1->next = B;
        B = p1;
    }
    // output linked list
    printf("linked list output:\n");
    for (p1 = B; p1 != NULL; p1 = p1->next) {
        printf("%d\n", p1->val);
    }

    sum = 0;
    for (p1 = B; p1 != NULL; p1 = p1->next) {
        sum += p1->val;
    }
    printf("linked list sum=%d\n", sum);

    p2 = B->next;
    p2 = p2->next;
    s24 = B->val + p2->val;
    printf("linked list s24=%d\n", s24);

    // reversing a linked list
    p2 = NULL;
    for (p1 = B; p1 != NULL; ) {
        p3 = p1->next;
        p1->next = p2;
        p2 = p1;
        p1 = p3;
    }
    B = p2;

    // output linked list
    printf("after reversing linked list\n");
    for (p1 = B; p1 != NULL; p1 = p1->next) {
        printf("%d\n", p1->val);
    }

    // creating the linked list in the right order
    B = NULL;
    for (i = 0; i < N; i++) {
        p1 = (struct list *)malloc(sizeof(struct list));
        scanf("%d", &j);
        p1->val = j;
        p1->next = NULL;
        if (B == NULL) B = p1;
        else p2->next = p1;
        p2 = p1;
    }
    // output linked list
    printf("reading in-order linked list\n");
    for (p1 = B; p1 != NULL; p1 = p1->next) {
        printf("%d\n", p1->val);
    }

    // remove the second node
    B->next = B->next->next;
    printf("after removing the second node:\n");
    for (p1 = B; p1 != NULL; p1 = p1->next) {
        printf("%d\n", p1->val);
    }

    // remove the first node
    B = B->next;
    printf("after removing the second node:\n");
    for (p1 = B; p1 != NULL; p1 = p1->next) {
        printf("%d\n", p1->val);
    }
}
