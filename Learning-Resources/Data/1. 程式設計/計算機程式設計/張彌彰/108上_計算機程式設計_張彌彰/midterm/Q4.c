// Q4 108061213 劉奕緯
//
// A positive integer may be represented as a sum of two prime numbers, and
// the representation may not be unique. For example,
//
// 10 = 3 + 7 = 5 + 5
//
// All these integers are prime numbers, except 10 itself.
// Note that 1 is not a prime number, and 2 and 3 cannot be a sum of
// two prime numbers.
//
// Given an integer N, N > 3, please write a program to find the number
// of integers, i, i <= N, which CANNOT be represented by a sum of two
// prime numbers. As mentioned, 1, 2, and 3 are automatically part of
// these numbers.
//
// Example of program execution (assuming N = 20):
// $ ./a.out
// 5 pos int <= 20 cannot be represented by a sum of two prime numbers.
//
// Your program should work for any N, N is an int and N > 3.
// Additional functions can be implemented for this question.

#include <stdio.h>
#include <stdlib.h>

#define N 30

int AnsOrnot(int n);			// checking if n is answer 
int isPrime(int i);				// checking if i is a primenumber
int main(void)
{
	int i;						// index
	int count = 0;				// how any number	

	for (i = 1; i < N; i++) {	// from 1 to N
		if (AnsOrnot(i) == 1)	// if it is an then we count
			count++;
	}
	printf("%d pos int <= %d cannot be", count, N);
	printf("represented by a sum of two prime numbers.\n");
								// output answer
	return 0;
}

int isPrime(int i) {
	int a;

	if (i <= 1) return 0; 		// if i <= 1 ,not a prime num
	for (a = 2; a < i; a++) {
		if (i % a == 0)
			return 0;
	}
	return 1;					// it is a prime num
}
int AnsOrnot(int n) {
	int i;

	for (i = 1; i <= n; i++) {
		if(isPrime(n - i) && isPrime(i))
				return 0;		// if i and n - i can be represent by
								// two prime numbers, it is not ans
	}
	return 1;					// else it is answer
}
