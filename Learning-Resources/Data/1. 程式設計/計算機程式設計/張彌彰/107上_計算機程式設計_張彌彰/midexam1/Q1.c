// Q1 u107061113 李柏葳
// Given an integer array A[N] with N different numbers.
// Please write a program to find the average of the positive elements of A.
//
// For example, if N = 10, and
// A[10] = {-16, 4, -17, 2, -4, -6, 14, 11, -12, 3}
//
// $ ./a.out
// A has 5 positive elements and the average is 6.8
//
// Note that your program should be general enough to handle different N
// and array A.
//

#include <stdio.h>

#define N 10

int A[10] = {-16, 4, -17, 2, -4, -6, 14, 11, -12, 3};

int main(void)
{
int i;	// to count which variable computer is examining
int positive = 0;	// to total the positives
float total = 0;	// to sum all positive numbers
float avg = 0;		// to avarage all positive numbers

for(i = 0; i <= N - 1; i++) {
	if(A[i] > 0) {
		positive++;
		total = total + A[i];
		}
	}
	avg = total / positive;
	printf("A has %d positive elements and the average is %g\n",
			positive, avg);

	return 0;
}
