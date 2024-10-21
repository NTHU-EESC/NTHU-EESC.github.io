// Q2 108061213 劉奕緯
// An positive integer N is said to be a perfect number if it is the sum
// of all of its proper divisors. That is,
//
// N = sum d, d < N and N % d = 0.
//
// For example, 6 is a perfect number since 6 has 3 proper divisors: 1, 2, and
// 3, and 6 = 1 + 2 + 3.
//
// Please write a C program to find first 4 perfect numbers.
// Example of program output:
// ./a.out
// Perfect number 1: 6
// ...

#include <stdio.h>

int main(void)
{
	int N, i, sum = 0;					// Number, index, divisors' sum
	int count = 0;						// #perfect number

	for (N = 2; count < 4; N++) {
		for (i = 1; i < N; i++) {
			if (N % i == 0) {
				sum += i;
			}
		}
		if (sum == N)					// if it is perfect num
			printf("Perfect number %d: %d\n", ++count, sum);
		sum = 0; 						// reset sum
	}
	return 0;
}
