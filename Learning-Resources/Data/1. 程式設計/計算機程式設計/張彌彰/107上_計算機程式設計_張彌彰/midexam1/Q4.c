// Q4 u107061113 李柏葳
// Given two positive integers d and N, d < N, d is said to be a divisor
// of N if N % d = 0.
// A positive integer N is an abundant2 number if the sum of all its divisors
// equals to N + 2. For example, 20 is an abundant2 number since it has 5
// divisors: 1, 2, 4, 5 and 10, and 1 + 2 + 4 + 5 + 10 = 22 = 20 + 2.
//
// Please write a C program to find the first 4 abundant2 numbers.
//
// Example output:
// $ ./a.out
//   Abundant2 number #1: 20
//   Abundant2 number #2: ??
//   Abundant2 number #3: ??
//   Abundant2 number #4: ??
//

#include <stdio.h>

int main(void)
{
	int num;    // to exam every number until find 4 abundant2
	int i;		// for exam the divisors of the number
	int sumdivisor = 0;	// to total all divisors of the number
	int abundant = 0;	// to count how many abundant2 we have found
	for (num = 2; abundant < 4; num++) {
		for (i = 2; i <= num/2.0 + 1; i++) {
			if (num % i == 0) {
				sumdivisor = sumdivisor + i;
			}
		}
		if (sumdivisor == num + 1) {
			abundant++;
			printf("Abundant2 number #%d: %d\n", abundant, num);
		}
		sumdivisor = 0;
	}
	return 0;
}
