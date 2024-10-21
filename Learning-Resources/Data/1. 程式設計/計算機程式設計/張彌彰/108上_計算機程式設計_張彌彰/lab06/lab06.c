// EE231002 Lab06. Permutations
// 108061213, 劉奕緯
// Date: Oct. 21, 2019

#include <stdio.h>
#define bool int
#define n 6 

int main(void)
{
	int p[n]; 							// set
	int i, j, k; 						// index 
	int temp;							// workspace for swap
	int cout; 							// index of permutation
	int end;
	for (i = 0; i < n; i++) p[i] = n - i; //asign element value n to 1
	j = 1;
	cout = 0;
	while (1) {						// end while we cannot find j
		printf("permutation #%d: ", ++cout);	
		for (i = 0; i < n; i++) printf("%d ", p[i]);
		printf("\n");					// above 3 line output a permutation
		for (j = n - 2; p[j] <= p[j + 1] && j >= 0; j--);// printf("/n%d===================================",j);
		if (j < 0) break;
		for (k = n - 1; p[k] >= p[j] ; k--); printf("k=%d",k);
		
		temp = p[k];					// swap p[j] and p[k]
		p[k] = p[j];
		p[j] = temp;
		for (i = j + 1 , end = n -1; i < end; i++,end--){
			temp = p[i];			// reverse j + 1 to n - 1
			p[i] = p[end];
			p[end] = temp;
		}
	}
	printf("  Total number of permutations is %d\n", cout);
	return 0;
}
