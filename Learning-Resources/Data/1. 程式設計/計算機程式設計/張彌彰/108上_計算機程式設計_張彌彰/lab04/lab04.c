// EE231003 Lab04. Pythagorean Triples
// 108061213, 劉奕緯
// Date: Jan. 1, 2020

#include <stdio.h>
#include <math.h>

int main (void)							// main function start
{
    int a, b, c;						// three edge of a triangle 
    int n = 0;								// the numbers of pyhtogorean triangle
	double x;							// the value of the last edge

	for (c = 2; c <= 20000; c++) {		// c <= 20000
		for (a = 2; a <= c / sqrt(2); a++) {
			x = sqrt(c * c - a * a); 
			b = x; 
			if (x - b == 0) {			// if x is integer then output
				printf("Pythagorean Triple #%d is (%d,%d,%d)\n", ++n, a, b, c);
			}
		}
	}
	return 0;							// funtion main end
}

