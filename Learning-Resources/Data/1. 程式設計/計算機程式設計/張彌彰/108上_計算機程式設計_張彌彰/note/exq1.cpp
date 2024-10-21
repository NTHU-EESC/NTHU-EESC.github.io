// exq1.cpp: function overloading

#include <cstdio>        // for C input and output functions

void pr(char);
void pr(char *);
void pr(int);
void pr(double);
void pr(int *ia, int n);

int main(void)
{
    char str[] = "this is a string";
    float sqrt2=1.414;

    pr('a');           printf("\n");
    pr(str);           printf("\n");
    pr(314);           printf("\n");
    pr(3.14159);       printf("\n");
    pr(sqrt2);         printf("\n");

    int a[] = {1, 3, 5, 7, 9};
    pr(a, 5);          printf("\n");
    return 0;
}

void pr(char c)
{
    printf("%c", c);
}

void pr(char *str)
{
    printf("%s", str);
}

void pr(int i)
{
    printf("%d", i);
}

void pr(double d)
{
    printf("%g", d);
}

void pr(int *ia, int n)
{
    int i;
    
    for (i = 0; i < n; i++) {
        printf("%d ", ia[i]);
    }
}
