// Q4 109061158 簡佳吟
// A large integer can be made easier to read if the digits are grouped
// together with ',' inserted between groups. For example, the number
//
// 12,3456,7890 
//
// is much easier to read.
// Please write a program that uses loops (for, while or do) to group
// the digits for large integers. For example, if
//
// long N = 1122334455667788990;
//
// then the program executes to get
// $ ./a.out
// 112,2334,4556,6778,8990
//

#include <stdio.h>

long N = 1122334455667788990;

int main(void)
{
	long i = 1;							// index for loop
	
	while (i < (N /10000)) i *= 10000;	// set i
	
	for ( ; i >= 10000; i /= 10000) {
		printf("%ld,", N / i % 10000);	// group the digit and print
	}
	printf("%ld\n", N % 10000);			// group the last digit
	return 0;							// done and return
}

