
// EE231000 Lab07 Matrix Determinant
// 109061158, 簡佳吟
// Date: 2020/11/16
#include <stdio.h>
#if !defined(N)
#define N 3
#endif

int P[N];
//int product = 1;
int count =0;
int Pandita(int P[N]);
int sum(int A[][N], int P[N], int sum_num);

int main(void) {
	int A[N][N] = {};
	int i, j, k;
	int sum;
	int nfact = 1;
	int product = 1;
	printf ("Matrix A is\n");
	for (j = 0; j < N; j++) {
		for (k = 0; k < N; k++) {
			scanf ("%d", &A[j][k]);
			printf ("%2d", A[j][k]);
		}
		printf ("\n");
	
	}

	for (i = 0; i < N; i++) {
		P[i] = i + 1;
		//printf("%d", P[i]);
	} 
	printf ("\n");
	for (i = 1; i <= N; i++) {
		nfact *= i;
	}
//	printf("%d\n", nfact);
	
	for (i = 0; i < N; i++) {
		product *= A[i][P[i] - 1]; 
		//printf ("%d %d\n",i,  product);
	}
	sum = product;
	//printf("%d", sum);
	for (j = 1; j < nfact; j++) {
		for (k = 0; k < N; k++) {
			product *= Pandita() *  A[k][P[k] - 1];
			printf("%d %d %d\n", k, P[k], count);
		}
		sum += product;
		printf("%d\n", sum);
	//	printf ("det(A) = %d", sum(A, P, product));
	
	}
	
	return 0;
}
	


int Pandita(int P[N]) {
	int i;
	int max;
	int j, k;
	int temp;
//	int static count = 0;
	for (i = N - 2; P[i] > P[i + 1] && i >=  0; i--) ;
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

	for (i = 0; i < N; i++) {
	printf ("%d",P[i]);}
//	if (count % 2 == 0) return 1;
	
//	if (count % 2 == 1) return -1;

	return 1;
}


/*int sum(int A[][N], int P[N], int sum_num) {
	int i;
	for (i = 0; i < N; i++) {
		product *= A[i][P[i] - 1] * Pandita(P);
		sum_num += product;
	}
	
	return sum_num;
}*/





















































































