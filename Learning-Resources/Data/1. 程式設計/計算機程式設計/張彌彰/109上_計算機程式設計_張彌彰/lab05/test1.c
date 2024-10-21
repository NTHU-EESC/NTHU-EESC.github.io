// EE231002 Lab05 Permutations
// 109061158, 簡佳吟
// Date: 2020.10.26


#include <stdio.h>
#define N 7


int main(void)
{

	int i, j, k;
	int foundj = 0, foundk = 0;
	int a[N];
	int temp;
	int serial = 1;


	for (i = 0; i < N; i++) {
		a[i] = i + 1;
	}


	for (i = 0; i < N; i++) {
		printf("permutation #%d: ", serial++);
		for (i = 0; i < N; i++) {
			printf("%d", a[i]);	
		}
		printf("\n");
		foundj = 0;
		foundk = 0;
	
		for (j = N - 2; j >=  0 && !foundj; j--) {
			if (a[j] < a[j + 1]) {
				for (k = N - 1; k > 0 && !foundk; k--) {
					if (a[j] < a[k]) {
						temp = a[j];
						a[j] = a[k];
						a[k] = temp;
						foundk = 1;
				for (i = 1; i <= (N - j - 1) / 2; i++) {
			
					temp = a[j + i];
			
					a[j + i] = a[N - i];
					a[N - i] = temp;
					
					}	

				}
			}
				foundj = 1;
		 }
					
		}


	}

	printf("   Total number of permutations is %d\n", serial - 1 );


	return 0;

}




































