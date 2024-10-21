// Q2 u107061113 李柏葳
// Given a matrix A[0:N-1][0:N-1], the 1-norm of A is define as
//
//            N-1    N-1
// norm1(A) = max (  sum | A[i][j] | )
//            j=0    i=0
//
// Please write a C function to calculate the 1-norm given matrix A.
// Note that | A[i][j] | means the absolute value of A[i][j].
//
#define N 3

double norm1(double A[N][N])
{
	int i,j,k;
	double sum[N] = {0}
	double absolute;
	double max = 0;
	
	for (j = 0; j < N; j++) {
		for (i = 0; i < N; i++) {
			if (A[i][j] < 0)
				absolute = A[i][j] * (-1);
			else absolute = A[i][j];
			sum[j] += absolute;
		}
	}
	for (j = 0; j < N; j++) {
		if (sum[j] > max)
			max = sum[j];
	}
	
	return max;
}
