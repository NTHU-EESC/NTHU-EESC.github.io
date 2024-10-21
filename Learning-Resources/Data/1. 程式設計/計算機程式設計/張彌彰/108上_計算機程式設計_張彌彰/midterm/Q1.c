// Q1 108061213 劉奕緯
//
// Given an NxN int matrix A, please write a program to find the
// column which has the largest column-sum and print the sum.
//
// For example, if
//
// A = {{0, 1, 2},
//      {3, 4, 5},
//      {6, 7, 8}};
//
// then program executes to get
// $ ./a.out
// Column 2 has the largest column-sum 15.
//

#include <stdio.h>

#define N 3

int A[N][N] = {{1, 2, 3}, {4, 5, 6}, {7, 8, 9}};

int main(void)
{
	int colsum[N];			// column-sum of n column
	int i, j;				// index
	int max = 0, maxaddr;	// the largest sum, and its location

	for (i = 0; i < N; i++)
		colsum[i] = 0;		// intialize column-sum	 
	for (i = 0; i < N; i++)
		for (j = 0; j < N; j++) {
			colsum[i] += A[j][i];
							// caculate column-sum
		}
	for (i = 0; i < N; i++) { 
							// find the largest column-sum
		if (max < colsum[i]) {
			maxaddr = i;
			max = colsum[i];
		}
	}
	printf("Column %d has the largest column-sum %d.\n", maxaddr, max);
							// output answer
	return 0;

}
