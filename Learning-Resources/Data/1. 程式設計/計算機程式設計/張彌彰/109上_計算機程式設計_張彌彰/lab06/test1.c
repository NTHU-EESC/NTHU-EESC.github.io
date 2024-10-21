






#include <stdio.h>
#define N 3

int A[N][N];
void init_array(int A[][N], int row, int col);

int main(void) {
	int i, j;
	init_array(A, 0, 0);

	for (i = 0; i < N; i++) {
		 for (j = 0; j < N; j++) {
		 	printf ("%2d", A[i][j]);
		 }
		 printf ("\n");
	 }
		 return 0;
							
}

void init_array(int A[][N], int row, int col) {
	
	if (row < N) {
		A[row][col] = (row + 1) % N;
		
		init_array(A, row + 1);
	
    }
    if (row == N) {
        indx = 0;
        init_array(A, row, col + 1);
    }

}







































										
