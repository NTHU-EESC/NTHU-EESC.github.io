// Q1 108061213 劉奕緯
// Given an NxN int matrix A, please write a function to
//   1. Swap row 0 and row r, 0 <= r <= N - 1,
//   2. Swap column N-1 and column c, 0 <= c <= N - 1.
//
// For example,
//
// A = { A00, A01, A02, A03,
//       A10, A11, A12, A13,
//       A20, A21, A22, A23,
//       A30, A31, A32, A33 }
//
// After calling pivot(A, 1, 2) we get
//
// A = { A10, A11, A13, A12,
//       A00, A01, A03, A02,
//       A20, A21, A23, A22,
//       A30, A31, A33, A32 }
//

#define N 5

void pivot(int A[N][N], int r, int c)
{
	int temp;
	int i;
	// swap rows
	for (i = 0; i < N; i++) {
		temp = A[r][i];
		A[r][i] = A[0][i];
		A[0][i] = temp;
	}
	// swap cols
	for (i = 0; i < N; i++) {
		temp = A[i][c];
		A[i][c] = A[i][N - 1];
		A[i][N - 1] = temp;
	}
}
