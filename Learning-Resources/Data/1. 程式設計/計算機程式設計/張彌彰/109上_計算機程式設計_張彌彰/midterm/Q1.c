// Q1 109061158 簡佳吟
// Given an integer array A of N elements, A[j], 0 <= j < N,
// please write a program to find the index j such that A[j + 1] - A[j]
// is the largest, 0 <= j < N - 1.
//
// For example, if
//
// int A[10] = {25, 7, 29, 17, 19,
//              29, 25, 21, 23, 17};
//
// then the program executes to get
// $ ./a.out
// Max(A[j + 1] - A[j]) is 22 when j = 1
//

#include <stdio.h>

#define N 10

int A[N] = {25, 7, 29, 17, 19,
            29, 25, 21, 23, 17};

int main(void)
{
	int i;			// index for loop
	int max = 0;	// the maximum
	int j;			// record the position of max
	
	for (i = 0; i < N - 1; i++) {
		if (A[i + 1] - A[i] > max) {	// find the max
			max = A[i + 1] - A[i];
			j = i;						// record the position
		}
	}
	printf("Max(A[j+ 1] - A[j]) is %d when j = %d\n", max, j);	// prompt
	
	
	
	return 0;							// done and return
}

