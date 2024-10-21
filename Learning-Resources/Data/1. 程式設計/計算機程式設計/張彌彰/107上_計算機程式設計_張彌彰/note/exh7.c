/*
 * exh7.c: pointer to functions
 *         input: none
 *         output: stdout, trigometric function output
 *         compilation with -lm option
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void print_func(double (*fx)(double), double x)
{
    printf("\t%10.4g", (*fx)(x));
}

int main(void)
{
    double x;
    double PI = asin(1.0) * 2;

    printf("PI=%g\n", PI);
    printf("%10s\t%10s\t%10s\t%10s\n",
        "x", "sin(x)", "cos(x)", "tan(x)");
    for (x = 0; x <= PI; x = x + PI / 10) {
        printf("%10.4g", x);
        print_func(sin, x);
        print_func(cos, x);
        print_func(tan, x);
        printf("\n");
    }
    return 0;
}
