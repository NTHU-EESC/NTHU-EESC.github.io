// EE2310 Lab07. Magic Square
// 108061213, 劉奕緯
// Oct. 31, 2019
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#define N 4						// the size of square matrix
#define gross (N * N * N + N)/ 2// sum of each columns, rows, diagonals

int M[N][N];					// original matrix
int unused[N * N];				// list of unused number 
int unusedqun = 0;				// # of unused number
int solution = 0;				// # of soltions
bool magiccheck();				// check if it is magic matrix
void print_matrix();			// output the magic matrix
void read_matrix();				// intput the orginal matrix mainly
void fill_entry();				// fill in unused numbers to matrix
void permutate();				// permutate the unused list sequence
void skip();
void swap();
void reverse();
int main(void)
{
 	int matrix[N][N];			

	read_matrix();
	for(;;) {					
		fill_entry(matrix);
		if (magiccheck(matrix))
			print_matrix(matrix);
		permutate();			// permutate to try another 
	}
	return 0;
}
void fill_entry(int m[N][N])	// if origin entry is 0, fill in unused number
{								// else be the same
	int i, j, k = 0;
	int rowsum;
	for (i = 0; i < N; i++){
		rowsum = 0;
		for (j = 0; j < N; j++){ 
			if (M[i][j] == 0) m[i][j] = unused[k++];
			else m[i][j] = M[i][j];
			rowsum += m[i][j];
		}
		if (rowsum != gross) 
				skip(k - 1);
	}
}
void skip(int j)
{
	int k, target = unused[j] - 1;
	printf("target num = %d",unused[j]);
	int find = 0;
//  	for (target = unused[j] - 1;find == 0 && target > 0; target--)
//		for (k = j + 1; k < unusedqun; k++)
//			if(unused[k] == target)find = 1;
	if(find == 0){
		reverse(j);
		permutate();
		return ;
	}
//	swap(j, k);
}
void reverse(int j)
{
	int i, l, temp;
	for (i = j + 1, l = unusedqun - 1; i < l;  i++, l--){
								// reverse
		temp = unused[i];
		unused[i] = unused[l];
		unused[l] = temp;
	}
}
void swap(int j, int k)
{
	int temp;
	
	temp = unused[j];
	unused[j] = unused[k];
	unused[k] = temp;
}
void print_matrix (int m[N][N])
{
	int i, j;

	printf("Solution %d:\n", ++solution);
	for (i = 0; i < N; i++) {
		for (j = 0; j < N; j++)
			printf("%4d", m[i][j]);
		printf("\n");
	}
	printf("\n");
}
void read_matrix()
{
	int i, j, k = 0;
	int used[N * N];			// list of used numbers
	bool exist;				

	for (i = 0; i < N; i++)		// input the origin matrix and list used numbers
		for (j = 0; j < N; j++){
			scanf("%d" ,&M[i][j]);
			if (M[i][j]) used[k++] = M[i][j]; 
		}
	for (i = N * N; i > 0; i--){
								// list out the unused numbers
		exist = false;		
		for (j = k; j>= 0; j--)
			if (used[j] == i) exist = true;
		if (exist == false) unused[unusedqun++] = i;
	}
}
bool magiccheck(int m[N][N])
{
	int i, j;
	int sum = 0;				// sum of a row, column or diagonal

	for (i = 0; i < N; i++)		// check diagonal's
		sum += m[i][i];
	if (sum != gross) return false;
	sum = 0;
	for (i = 0; i < N; i++)
		sum += m[N - 1 - i][i];
	if (sum != gross) return false;
	sum = 0;
	for (i = 0; i < N; i++){	// check rows
		for (j = 0; j < N; j++)
			sum += m[i][j];
		if (sum != gross) return false;
		sum = 0;
	}
	for (i = 0; i < N; i++){	// check columns
		for (j = 0; j < N; j++)
			sum += m[j][i];
		if (sum != gross) return false;
		sum = 0;
	}
	return true;
}
void permutate(){				// Pandia permutation
	int i, j, k, l;
	int temp;

	for (j = unusedqun - 2; unused[j] <= unused[j + 1] && j >= 0; j--);
								// find j
	if (j < 0){					// cannot permutate anymore. i.e. we had tried
								// all the matrixs. Therefore, we output the 
								// total number of solution and then end this
								// program
		printf("Number of solutions found: %d\n", solution);
		exit(0);
	}
	for (k = unusedqun - 1; unused[k] >= unused[j] && k >= 0; k--);
								// find k
								// swap 
	temp = unused[j];
	unused[j] = unused[k];
	unused[k] = temp;
	for (i = j + 1, l = unusedqun - 1; i < l;  i++, l--){
								// reverse
		temp = unused[i];
		unused[i] = unused[l];
		unused[l] = temp;
	}
}
