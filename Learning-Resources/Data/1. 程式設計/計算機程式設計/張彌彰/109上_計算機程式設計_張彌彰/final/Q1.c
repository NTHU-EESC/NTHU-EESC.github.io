// Q1 109061158 簡佳吟
// Given an integer NxN matrix A, please write a function to find
// the smallest column-sum of A
//
// For example, if N = 3
//
// int A[N][N] = { {7, 8, 9}, {4, 5, 6}, {1, 2, 3}};
//
// then the function returns 12.
//

#define N 10
int minCsum(int A[N][N])
{
	int sum[N] = {0};		// for sum column
	int i, j;		// index for loop
	int min;		// the min

	for (j = 0; j < N; j++) {
		for (i = 0; i < N; i++) {
			sum[j] += A[i][j];			// sum each column
		}
	}
	min = sum[0];						// initialize min
	for (i = 0; i < N; i++) {			// find the min
		if (sum[i] < min) {
			min = sum[i];
		} 
	}	
		
	return min;			// done and return
}


