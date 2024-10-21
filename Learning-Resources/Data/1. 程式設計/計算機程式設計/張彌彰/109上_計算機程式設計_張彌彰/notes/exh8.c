// exh8.c: array of pointers to functions
//         input: none
//         output: stdout, trigometric function output
//         compilation with -lm option

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

double (*fx[3])() = {sin, cos, tan};

int main(void)
{
    double x;
    double PI = asin(1.0) * 2;

    printf("PI=%g\n", PI);
    printf("%10s %10s %10s %10s\n",
        "x", "sin", "cos", "tan");
    for (x = 0; x <= PI; x = x + PI / 10) {
        printf("%10.4g %10.4g %10.4g %10.4g\n",
            x, (*fx[0])(x), (*fx[1])(x), (*fx[2])(x));
    }
    return 0;
}
