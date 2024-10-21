





#include <stdio.h>
#define N 3


int A[N][N];
int Nsol = 0;
int count = 0;

void make(int x,int y);
int judge(int x, int y);
void print();
void init_array(int A[][N], int row, int col);

int main(void) {

	
	
	
	printf ("Total number solutions found: %d\n", Nsol);
	





	return 0;
}

void make(int x, int y) {
	int i;
	int count = 0;
	int xx, yy;
	if (count == N * N) {
		print();
		Nsol++;
	}
	else {
		for (i = 1; i <= N; i++) {
			A[x][y] = i;
			count++;
			if (judge(x, y)) {
				yy =(y +1) % N;
				if (y == N - 1)
					xx = x + 1;
				else xx = x;
			make(xx, yy);
									
			}
			--count;
			
		}

	}

}

int judge(int x, int y) {
	int i;
	int judgeN = A[x][y];
	for (i = 0; i < y; i++) {
		if (judgeN == A[x][i]) {
			return 0;
		}
	}
	for (i = 0; i < x; i++) {
		if (judgeN == A[i][y]) {
			return 0;
		}
	}


	return 1;

}

void print() {

	int i, j;
	printf ("Solution %d:\n", Nsol + 1);
	for (i = 0; i < N; i++) {
		for (j = 0; j < N; j++) {
			printf ("%2d", A[i][j]);
		}
		printf ("\n");
	
	}





}








































