// Q3 u107061113 李柏葳
// Please write a RECURSIVE function to print an integer N in base 5
// representation. For example,
//    111 = 4 * 5^2 + 2 * 5 + 1
// Thus, calling the function printInBase5(111) prints out: 421

#include <stdio.h>

void printInBase5(int N)
{
	int i,j;
	int left = N;
	int coef;
	int num;
	int out = 1;

	for (i = 0; out; i++) {
		num = 1;
		for (j = 0; j < i; j++)
			num *= 5;
		if ((left / num) < 5) {
			coef = left / num;
			out--;
		}
	}				
	printf("%d", coef);
	left -= (coef * num);
	if (left == 0) 
		return;
	else printInBase5(left);
}

