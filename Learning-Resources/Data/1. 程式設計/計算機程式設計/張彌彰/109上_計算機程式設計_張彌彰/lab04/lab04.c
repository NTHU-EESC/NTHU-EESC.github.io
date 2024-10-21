//EE231002 Lab04. Solving Integer Equations
//109061158, 簡佳吟
//Date: 2020.10.19


#include <stdio.h>
#define MAX 5000
int main(void)
{
	long int n, a, b;		// satisfies the given equation n^3 = a^2 + b^2
	long int x, y;			/* satisfies a = x * (x^2 + y^2)
										 b = y * (x^2 + y^2) */			
	int k = 1;				// serial number of solution			
	

	for (n = 2; n <= MAX ; n++)  {					// scan for 1 < n < MAX
		if (n % 2 == 0  || n % 4 == 1) {			/* n must be a square
                                   						 of	some number */  
			for (x = 1; x <= 71; x++) {				// scan x from 1 to 71
				for (y = x; y <= 71; y++) { 		// scan y form x to 71
					a = x * (x * x + y * y);		// assign a and b
					b = y * (x * x + y * y);
					if ((a * a + b * b) == (n * n * n)) {		// select
						printf("%d: %d ^ 3 = %d ^ 2 + %d ^ 2\n",
														k++, n, a, b);
																// prompt
						x = 72;
						y = 72;						// jump out of the loop
					}
					
				} 	
				
			}	
		
		
		}

	}
	printf("%d solutions found for n <= %d.\n", k - 1, MAX);	// prompt
	return 0;										// done and return
}
/* provement
 * Let x, y, z be positive  integers which satisfy the equation
 * x ^ 2 + y ^ 2 = Z ^ 2
 * multiply both sides by z ^ 4,and we can get the equation
 * (x ^ 2 * z ^ 4) + (y ^ 2 * z ^ 4) = z ^ 6
 * (x * z ^ 2) ^ 2 + (y * z ^ 2) = (z ^ 2) ^ 3
 * (x * (x ^ 2 + y ^ 2)) ^ 2 + (y * (x ^ 2 + y ^ 2)) ^ 2
 * 									= ((x ^ 2 + y ^ 2) ^ 3
 * Then, let a = x * (x ^ 2 + y ^ 2) and b = y * (x ^ 2 + y ^ 2)
 * and n = x ^ 2 + y ^ 2, which is square of some integer
 * if n is a square of an even number, n % 2 = 0
 * if n is a square of an odd number,
 * let the odd number be 2k+1, and k is a positive integer
 * (2k+1) ^ 2 = 4k ^ 2 + 4k + 1
 * Thus, (2k+1) ^ 2 % 4 = 1 */










