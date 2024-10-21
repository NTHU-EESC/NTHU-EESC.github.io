// Q3 u107061113 李柏葳
// Given the following recursion relation
//
// f(n) = 1,                if n == 0,
//                 2
//      = 1 + -----------,  otherwise.
//             1 + f(n-1)
//
// Please write a C program to approximate f(n) as n approaches infinite.
// Note this is can be done by finding n such that
//   | f(n) - f(n-1) | < 1e-7.
//
// Program output should have the following format:
// $ ./a.out
// f = 1.73205

#include <stdio.h>
#define eps 1e-7

int main(void)
{
	int i;
	double a = 0; // set a = f(n)
	double b = 0; // set b = f(n-1)
	int out = 0;  
	double sum;	  // to get a - b
	while(out == 0) {
		a = 1 + 2 / (1 + a);
		sum = a - b;
		if (sum > 0 && sum < eps) {	// to examine |f(n)i - f(n - 1)| < eps
			printf("f = %.5lf\n", a);
			out++;
		}
		if (sum <= 0 && sum > eps*(-1)) {
			printf("f = %.5lf\n", a);
			out++;
		}
		b = a;			// store f(n-1) value
	}
	return 0;
}

