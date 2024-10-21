// Q2 u107061113 李柏葳
// Given a double array A[N], please write a function ADD to
//
// 1. replace A[0] by A[0]+A[1],
// 2. move A[2:N-1] to A[1:N-2],
// 3. reset A[N-1] to 0.
//
// Thus, before calling ADD we have
//     A = {A[0],      A[1], A[2], ..., A[N-2], A[N-1]}
// then after calling ADD we have
//     A = {A[0]+A[1], A[2], A[3], ..., A[N-1], 0}
//
// Note that your function should be general enough to handle different N
// and A array.
//

#include <stdio.h>

#define N 10

void ADD(double A[N])
{	
	int i;

	A[0] = A[0] + A[1];          // step 1
	for (i = 1; i <= N-2; i++) {	// step 2
		A[i] = A[i + 1];
		}
	A[N - 1] = 0;	// step 3
	return;
}


