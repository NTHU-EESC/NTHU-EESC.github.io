// Q2 108061213 劉奕緯
//
// A int matrix is defined as
//
// A[r][c] = c + 2,               if r == 0,
//           r + 2,               if c == 0,
//           A[r - 1][c] * A[r][c - 1], otherwise.
//
// Please write A NON-RECURSIVE function to create such a matrix.
//

#include <stdio.h>

#define N 5

int A[N][N];

void init(int A[N][N])
{
	int r, c; 					//index
								
	for (r = 0; r < N; r++) {	// we already know r = 0 or s = 0 is 2
		A[0][r] = 2;
		A[r][0] = 2;
	} 
	for (r = 1; r < N; r++)		// start caculate (row by row)
		for ( c = 1; c < N; c++){
			A[r][c] = A[r - 1][c] * A[r][c - 1];
		}						// end
}






