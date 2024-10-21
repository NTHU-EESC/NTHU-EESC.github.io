// Q3 108061213 劉奕緯
//
// Given a k-digit decimal integer, N = d(k)...d(1), the DigitSum is
// defined as
//
// DigitSum(N) = sum d(k)
//
// For example, N = 789, then
//  DigitSum(N) = DigitSum(789) = 7 + 8 + 9 = 24
//
// Given any integer N, a recursive function G(N) is defined as
//
// G(N) = N,                  if N < 10,
//        G(2 * DigitSum(N)), otherwise.
//
// For example, G(789) = G(2 * 24) = G(2 * 12) = G(6) = 6.
//
// Given any integer, N, please write A recursive function to return
// the value of G(N).

#include <stdio.h>
#include <stdlib.h>

int G(int N)
{
	int digsum;					// digitsum of N

	do {
		digsum = 0;
		while (N > 0) {	
			digsum += N % 10;	// add a digit
			N /= 10;			// discard that digit added
		}
		N = digsum * 2;			// 2 * digitsum	
	} while (digsum >= 10);		// while digitsum < 10 we got answer
	return digsum;
}

