// EE231002 Lab02. Approximating Pi
// 108061213, 劉奕緯
// Jan. 1, 2020

#include <stdio.h>								// standard io library
#define part 1.0 / i / (i + 1) / (i + 2) - 1.0 / (i + 2) / (i + 3) / (i + 4)
												// a partial sum
int main(void)
{												// main fuction start
	double s = 0, i; 							// partial sums, index
	
	i = 2;										// calculate s2
	s += part;
	printf("PI2 = %.5lf\n", s * 4 + 3 );		// output pi2
	i = 6;										// calculate s4
	s += part;
	printf("PI4 = %.5lf\n", s * 4 + 3 );		// output pi4
	i = 10;										// caculate s6
	s += part;
	printf("PI6 = %.5lf\n", s * 4 + 3 );		// output pi6
	i = 14;										// caculate s8
	s += part;
	printf("PI8 = %.5lf\n", s * 4 + 3 );		// output pi8
	i = 18;										// calculate s10		
	s += part;									
	printf("PI10 = %.5lf\n", s * 4 + 3 );		// output pi10
	i = 22;										// calculate s12
	s += part;									
	printf("PI12 = %.5lf\n", s * 4 + 3 );		// output pi12
	return 0;	
}												
