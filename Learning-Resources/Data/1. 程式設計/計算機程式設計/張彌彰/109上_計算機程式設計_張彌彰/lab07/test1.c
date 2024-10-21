// EE231000 Lab07 Matrix Determinant
// 109061158, 簡佳吟
// Date: 2020/11/16
#include <stdio.h>
#if !defined(N)
#define N 3
#endif

int Pandita(int P[N]); 
// This function generate the next lexicographic permutation based on
// Pandita algorithm
// input : P contains the previous permutation
// output : return sgn of cumulative number of swappings
// and return 0 if no more permutation
// P contains the next permutation

int main(void) {
	int A[N][N];		// two dimension array to store
	int P[N];			// one dimension array for Pandita
	int i, j, k;		// index for for loop
	long int sum = 0;	// sum the whole product
	long int product = 1;// 
	int sgn = 1;
	int flag =1;

	printf ("Matrix A is\n");
	for (j = 0; j < N; j++) {
		for (k = 0; k < N; k++) {
			scanf ("%d", &A[j][k]);
			printf (" %2d", A[j][k]);
		}
		printf ("\n");
	
	}

	for (i = 0; i < N; i++) {
		P[i] = i + 1;
	} 
		
	while (flag) {
		product = 1;
		for (i = 0; i < N; i++) {
			product *= A[i][P[i] - 1];
		}
		if (sgn == 0) {
			flag = 0;
		}	
		if (flag) {
			sum += sgn * product;
		}	
		sgn = Pandita(P);	
	
	}
	printf ("det(A) = %ld", sum);

	return 0;
}
	


int Pandita(int P[N]) {
	int i;
	int max;
	int j, k;
	int temp;
	int static count = 0;
	for (i = N - 2; P[i] > P[i + 1] && i >= 0; i--) ;
	if ( i == -1) {
		return 0;
	}
	for (max = N - 1; P[max] < P[i]; max--) ;
	temp = P[i];
	P[i] = P[max];
	P[max] = temp;
	count++;
	for (k = i + 1, j = N - 1; k < j; k++, j--) {
		temp = P[k];
		P[k] = P[j];
		P[j] = temp;
		count++;
	}
	if (count % 2 == 0) {
		return 1;
	}
	else { 
		return -1;
	}

}























































































