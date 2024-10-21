// EE2310 Lab09. GCD and LCM
// 108061213, 劉奕緯
// Nov. 19, 2019

#include<stdio.h>						// standard I/O
#include<math.h>						// to use power function
#define S 20							// size of arrays

void factorize(int N, int factors[S], int power[S]);
										// factorizes N into prime factors
										// storing in (factors array) and
										// associated powers (power array). 
void GCD(int Afactors[S], int Apower[S], int Bfactors[S], int Bpower[S],
		 int Cfactors[S], int Cpower[S]);
										// takes two factors arrays & two power
										// arrays to produce two output arrays:
										// one for GCD factors 
										// and the other for GCD power.
void LCM(int Afactors[S], int Apower[S], int Bfactors[S], int Bpower[S], 
		 int Cfactors[S], int Cpower[S]);
										// takes two factors arrays & two power
										// arrays to produce two output arrays:
										// one for LCM factors 
										// and the other for LCM power.
	int ia, ib, ic;						// index of a's, b's, c's arrays
void write(int factors[S], int power[S]);
										//  prints out the factors and power
										// arrays in product of prime 
										// and the integer calculated 
										// using this product from.
										
int main(void) 
{
	int a, afactor[S] = {0}, apower[S] = {0};
										// a & a's factors & power of factors
	int b, bfactor[S] = {0}, bpower[S] = {0};
										// b & b's factors & power of factors
	int cfactor[S] = {0}, cpower[S] = {0};
										// factors & its power of GCD or LCM
										// since LCM must longer then GCD, i
										// use an arry to store it

	printf("input A: ");				// prompt for a
	scanf("%d", &a);					// input a
	printf("input B: ");				// prompt for b
	scanf("%d", &b);					// input b
	factorize(a, afactor, apower);		// factorizing a
	printf("  A = ");					// and output
	write(afactor, apower);
	factorize(b, bfactor, bpower);		// factorizing b
	printf("  B = ");					// and output
	write(bfactor, bpower);
	GCD(afactor, apower, bfactor,bpower, cfactor, cpower);
	printf("  GCD(A,B) = ");			// get GCD of a and b
	write(cfactor, cpower);				// and ouput
	LCM(afactor, apower, bfactor,bpower, cfactor, cpower);
	printf("  LCM(A,B) = ");			// get LCM of a and b
	write(cfactor, cpower);				// and output
	return 0;
}


void factorize(int N, int factors[S], int power[S])
{										// factorizes N into prime factors
										// storing in (factors array) and
										// associated powers (power array). 
	int i, j;							// index
	
	i = j = 0;
	if(N % 2 == 0) {					// get all the two 
		factors[j] = 2;
		do {
			power[j]++;
			N /= 2;
		} while (N % 2 == 0);		
		j++;							// next factor
	}
	for (i = 3; i <= N; i += 2){		// since N now must be odd
										// its factors must be odds
		if(N % i == 0) {				// get all the i
			factors[j] = i;
			do {
				power[j]++;
				N /= i;
			} while (N % i == 0);
			j++;						// next factor
		}	
	}
	factors[j] = power[j] = 1;			// the final element to be (1,1)
}
void GCD(int Afactors[S], int Apower[S], int Bfactors[S], int Bpower[S], int Cfactors[S], int Cpower[S])
{										// takes two factors arrays & two power
										// arrays to produce two output arrays:
										// one for GCD factors 
										// and the other for GCD power.
	int ia, ib, ic;						// index of a's, b's, c's arrays 

	ia = ib = ic = 0;
	for ( ; Afactors[ia] != 1; ia++) {
										// we use a loop manange to 
										// gain common factor
										// by checking all Afactors
		for ( ; Bfactors[ib] < Afactors[ia]; ib++) ;
										// while this loop end 
										// Afactors[ia] is equal or smaller
										// than Bfactors[ib]
		if (Afactors[ia] == Bfactors[ib]) {
										// if equal we put factor into c's arrays
			Cfactors[ic] = Afactors[ia];
			if(Apower[ia] > Bpower[ib])	// and put the smaller power
				Cpower[ic] = Bpower[ib];
			else						
				Cpower[ic] = Apower[ia];
			ic++;
		}	
		else ib--;						// else let ib back, since we don't
										// know next afactor is eqal to 
										// previos bfactor 
	}
	Cpower[ic] = Cfactors[ic] = 1;		// final element be (1,1)
}
void LCM(int Afactors[S], int Apower[S], int Bfactors[S], int Bpower[S], int Cfactors[S], int Cpower[S])
{										// takes two factors arrays & two power
										// arrays to produce two output arrays:
										// one for LCM factors 
										// and the other for LCM power.
	int ia, ib, ic;						// index of a's, b's, c's arrays

	ia = ib = ic = 0;
	for ( ; Afactors[ia] != 1; ia++) {	
		for ( ; Bfactors[ib] < Afactors[ia] && Bfactors[ib] != 1; ib++) {
										// get all factors is smaller 
										// than Afactors[ia]
			Cfactors[ic] = Bfactors[ib];
			Cpower[ic] = Bpower[ib];
			ic++;
		}
										// than get Afactors[ia]
		if (Afactors[ia] == Bfactors[ib]) {
										// if a and b have same factor
										// get the bigger power
			Cfactors[ic] = Afactors[ia];
			if(Apower[ia] < Bpower[ib])
				Cpower[ic] = Bpower[ib];
			else
				Cpower[ic] = Apower[ia];
			ic++;
			ib++;
		}	
		else {							// easily we cant get Afactors[ia]
										// and Apower[ia]
										// when only "a" have 
			Cfactors[ic] = Afactors[ia];
			Cpower[ic] = Apower[ia];
			ic++;
		}
	}									// end when we get all a's factors
	while ( Bfactors[ib] != 1) {		// get all b's factors
		Cfactors[ic] = Bfactors[ib];
		Cpower[ic] = Bpower[ib];
		ib++;
		ic++;
	}	
	Cpower[ic] = Cfactors[ic] = 1;
}
void write(int factors[S], int power[S])
{										//  prints out the factors and power
										// arrays in product of prime 
										// and the integer calculated 
										// using this product from.
	int i = 0;							// index
	int product = 1;					// total 
	
	printf("%d", factors[0]);			// output the first factor
	if (power[0] != 1) 					// we couldn't output ^1
		printf("^%d", power[0]);
	product *= pow(factors[0], power[0]);
	if(factors[0] != 1) {				// if factors[0] == 1 we know it ends
										// output else factors
		for (i = 1; factors[i] != 1; i++) {
			printf(" * %d", factors[i]);
			if (power[i] != 1) 			// we wouldn't like outputing ^1
				printf("^%d", power[i]);
			product *= pow(factors[i], power[i]);
		}
	}
	printf(" = %d\n", product);
}
