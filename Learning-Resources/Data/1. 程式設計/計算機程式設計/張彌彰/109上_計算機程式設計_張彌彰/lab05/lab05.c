// EE231002 Lab05 Permutations
// 109061158, 簡佳吟
// Date: 2020.10.26


#include <stdio.h>
#define N 3


int main(void)
{

	int i, j, k;				// index i, j, k
	int foundj, foundk;			// indication for finding j and k
	int a[N];					// array 
	int temp;					// strore number temporarily
	int serial = 1;				// serial number of solutions


	for (i = 0; i < N; i++) {
		a[i] = i + 1;
		printf("%d %d\n", i, a[i] );						// assign number from 1 to N 
	}


	for (i = 0; i < N; i++) {						
		printf("permutation #%d:", serial++);
		for (i = 0; i < N; i++) {
			printf(" %d", a[i]);	
		}
		printf("\n");						// prompt output numbers
		foundj = 0;							// assign 0 to foundj
		foundk = 0;							// assign 0 to foundk
	
		for (j = N - 2; j >=  0 && !foundj; j--) {		
			if (a[j] < a[j + 1]) {  
				printf("111");											// find j
				for (k = N - 1; k > 0 && !foundk; k--) {
					if (a[j] < a[k]) {						// find k
						temp = a[j];
						a[j] = a[k];
						a[k] = temp;					// swap a[i] and a[k]
						foundk = 1;						// break
						for (i = 1; i <= (N - j - 1) / 2; i++) {
							temp = a[j + i];
							a[j + i] = a[N - i];
							a[N - i] = temp;		// reverse the number 
													// from j + 1 to N - 1
					
						}		

					}
				}
			foundj = 1;							// break
		 	}
					
		}


	}

	printf("   Total number of permutations is %d\n", serial - 1 );	// prompt


	return 0;									// done and return

}




































