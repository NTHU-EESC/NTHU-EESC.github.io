// Q2 109061158 簡佳吟
// Given an integer array A of N elements, A[j], 0 <= j < N,
// N is an even number, please write a program to reverse A array.
//
// For example, if
//
// int A[10] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};
//
// then the program executes to get
// $ ./a.out
// A = 9 8 7 6 5 4 3 2 1 0
//
// Note that the memory content of A must be changed.

#include <stdio.h>

#define N 10

int A[N] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};

int main(void)
{

	int temp;									// store number		
	int i;										// index

	printf("A =");								// prompt
	for (i = 0; i < N / 2; i++) {
		temp = A[i];
		A[i] = A[N - 1 - i];
		A[N - 1 - i] = temp;					// reverse array
	
	}
	for (i = 0; i < N; i++) {					// 	print numbers
		printf(" %d", A[i]);
	}
	printf("\n");								
	return 0;									//done and return

}

