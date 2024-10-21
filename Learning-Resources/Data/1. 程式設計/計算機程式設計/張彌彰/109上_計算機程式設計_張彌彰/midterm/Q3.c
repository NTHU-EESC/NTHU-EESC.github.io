// Q3 109061158 簡佳吟
// Given a positive integer N, N may or may not be expressed as
// the sum of two prime numbers.
//
//   N = P1 + P2
//
// Please write a program to find all combinations of (P1, P2), both P1
// and P2 are prime numbers and P1 + P2 = N.
//
// For example, if N = 8, then the program executes to get
// $ ./a.out
// Set 1: 3, 5.
// Set 2: 5, 3.
// Number of sets found: 2.
//
// On the other hand, if N = 11, there are no prime numbers P1 and P2
// such that P1 + P2 = 11. We then have
// $ ./a.out
// Number of sets found: 0.
//

#include <stdio.h>

#define N 8

int main(void)
{
	int i;  			// index for loop
	int p1, p2;			// prime number 
	int sol = 1;		// number of solution
	int isprime1, isprime2;		// for checking prime number

	for(p1 = 2, p2 = N - 2; p1 < N - 2 && p2 > 2; p1++, p2--) {
		isprime1 = 1;							// reset
		isprime2 = 1;
		for (i = 2; i < p1 && isprime1; i++){	// check whether p1 i prime 
			if (p1 % i == 0) {
				isprime1 = 0;
			}
		} 
		for (i = 2; i < p2 && isprime2; i++) {	// check whether p2 is prime
			if (p2 % i == 0) {
				isprime2 = 0;
			}
		}
		if (isprime1 && isprime2) {									// if both p1 and p2
														// are prime, prompt
			printf("Set %d: %d, %d.\n", sol++, p1, p2);
		}
	} 	
	printf("Number of sets found: %d.\n", sol - 1);		// prompt
	return 0;											// done and return
}

