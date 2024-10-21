// EE2310 Lab08. Matrix Determinant
// 108081213, 劉奕緯
// Nov. 11, 2019

#include<stdio.h>
#if !defined(N)
#define N 3
#endif

double det(double A[N][N], int dim);	// caculate the determinant of a
 										// "dim" * "dim" matrix "A"
void Minor(int i, int dim,  double minor[N][N], double M[N][N]);
										// get minor matrix "Minor"
										// by removing row 0 and column "i" 
										// from a "dim" * "dim" matrix "M"
int main(void)
{
	int i, j;							// loop index
	double Matrix[N][N];
	
	for (i = 0; i < N; i++)				// input matrix
		for (j = 0; j < N; j++)
			scanf("%lf", &Matrix[i][j]);
	printf("Matrix A is\n");			// output matrix
	for (i = 0; i < N; i++) {
		for (j = 0; j < N; j++)
			printf("%3g", Matrix[i][j]);
		printf("\n");
	}
	printf("det(A) = %g\n", det(Matrix, N));
										// output answer
	return 0;
}

void Minor(int i, int dim,  double minor[N][N], double M[N][N])
{
	int m, n;							// loop index
	int col;							// index of column
	
	col = 0;
	for (n = 0; n < dim; n++) {
		if (n != i) {					// Not copying i column
			for (m = 0; m < dim; m++)
				minor[m][col] = M[m + 1][n];	
			col++;						// next column
			}
	}
}


double det(double A[N][N], int dim)
{
	double d = 0;						// determinant		
	int sign = 1;						// sign of cofactors 
	double minor[N][N];					// to store minor matrix
	int i;								// loop index
										
	if (dim == 1) return A[0][0];		// x * det(I(1*1) ) = a * 1 
	for (i = 0; i < dim; i++) {			// expansion using first row
		Minor(i, dim, minor, A);		// get minor of A[0][i] 
										// and store in array"minor"
		d += sign * A[0][i] * det(minor, dim - 1);
		sign *= -1;						// use the given formula
	}
	return d;
}
