/*  EE231002 Lab05. Permutationsi
	107061113, 李柏葳
	Date:2018/10/22
*/

#include <stdio.h>
#define N 8

int main(void) {
	int j;					// largest j for permu[j] < permu[j-1]
	int k;					// largrst j for permu[j] < permu[k]	
	int i;
	int out = 0;			// get out the loop if not find j
	int permu[N - 1];		// to store permutation's numbers
	int temp;               // to switch number
	int num = 1;			// to count # number
 
	for (i = 0; i < N; i++)	// set num in array
		permu[i] = i + 1;

	while ( printf("permutation #%d:", num) ) {	// print result
		num++;	// to count #
		for (i = 0; i < N; i++)
			printf("%2d", permu[i]);
		printf("\n");

		for (i = N - 2; out == 0; i--) {	// searching index j
			if (i <= -1)
				return 0;
			if (permu[i] < permu [i + 1]) {	
				j = i;
				out++;
			}
		}
		out = 0;	// reset out value

		for (i = N - 1; out == 0; i--) {	// find index k
			if (permu[i] > permu[j]) {
				k = i;
				out++;
			}
		}
		out = 0;	// reset out value

		temp = permu[j];	// swap permu[j] with permu[k]
		permu[j] = permu[k];
		permu[k] = temp;

		for (i = j + 1; i <= (N + j) / 2; i++) {
			// reverse permu[j + 1] to permu[N - 1]
			temp = permu[i];
			permu[i] = permu[N + j - i];
			permu[N + j - i] = temp;
		}
	}

	return 0;
}


