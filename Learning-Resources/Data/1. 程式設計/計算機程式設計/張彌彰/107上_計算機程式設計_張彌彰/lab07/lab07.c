/*  EE231002 Lab07. Matrix Determinants
	107061113, 李柏葳
	Date:2018/11/10
*/

#include <stdio.h>

#if !defined(N)	// to set a N * N matrix
#define N 
#endif

/*****************************************************************************
*      this program use the Leibniz formula to find the delta of the matrix. *
*  delta is form by the sum of all product of each row and corresponding     *
*  column.which is determined by the permutationse.                          *
*  repeatedly applying Pandita’s algorithm to  generate all possible         *
*  permutations.                                                             *
*  so in order to do it, we have to                                          *
*  1) scan the input matrix                                                  *
*  2) create a function to find all permutations and its sgn                 *
*  3) sum all of the product from row * corresponding matrix                 *
*  4) print out proper answer and input matrix                               *
*****************************************************************************/


int column[N] = {0};	// to store corresponding permutations.
int sgn = 1;	// store sgn value
int end = 1;
int presgn = 1;	// store previous one sgn value
int matrix[N][N] = {0};	// store input matrix

	// 2) function that find all permutations and its sgn 

void Pandita(int column[]){
	int m,n = 0;
	int j = 0;
	int k = 0;
	int exit = 1;
	int out = 1;
	int temp = 0;
	int swap = 1;

	/* Find the largest index j such that A[j] < A[j + 1].
	   If no such index exists, the permutation is the last permutation. */

	for (m = N - 1; exit == 1; m--) {
		if (column[m] < column[m + 1]){
			j = m;
			exit--;	// exit the loop if find index j
		}
	}
	exit = 1;
	if (j == 0) {	// return if no such index exist
		end = 0;
		return;
	}

	// Find the largest index k such that A[j] < A[k]

	for (n = N; out == 1; n--) {
		if (column[n] > column[j]) {
			out--;	// exit loop if find index k
			k = n;
		}
	}
	out = 1;	//reset value

	// to switch number in column[j] and column[k]

	temp = column[j];
	column[j] = column[k];
	column[k] = temp;

	// Reverse the sequence from column[j + 1] up to the last element

	for (m = j + 1; m <= (N + j) / 2; m++) {
		temp = column[m];
		column[m] = column[N + j + 1 - m];
		column[N + j + 1 - m] = temp;
		swap++;
	}
	
	// to determine sgn by previous sgn and swap times is odd or even

	if (swap % 2 == 0) {	
		sgn = 1;
	}
	if (swap % 2 == 1) {
		sgn = -1;
	}
	sgn *= presgn;
	presgn = sgn;

	return;
}

int main (void){
	int i,j;
	int delta = 0;
	int product = 1;

	// set the first permutation

	for (i = 1; i<= N; i++) {
		column[i] = i;
	}

	// 1) scan the input matrix

	for (i = 1; i <= N; i++) {
		for (j = 1; j <= N; j++) {
			scanf("%d", &matrix[i][j]);
		}
	}

	// to get the delta of the matrix
	
	while (end) {
		for ( i = 1; i <= N; i++) {	 
		// 3) to product each row and corresponding column
			product *= (sgn * matrix[i][column[i]]);
		}
		delta += product;	// sum all products into delta
		product = 1;	//reset product value
		Pandita (column);	
			// to call out function to get new permutation and sgn
	}

	// 4) print out the format which required by the topic

	printf("Input matrix is");
	for (i = 1; i <= N; i++) {	// print out input matrix
		printf("\n ");	
		for (j = 1; j <= N; j++) {
			printf(" %d", matrix[i][j]);
		}
	}
	printf("\nDet = %ld\n",delta);	// print out delta

	return 0; // function terminates here
}

