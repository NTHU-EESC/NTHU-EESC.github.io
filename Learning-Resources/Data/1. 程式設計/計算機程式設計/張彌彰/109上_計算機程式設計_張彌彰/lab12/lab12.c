// EE231002 Lab12. Polynomials
// 109061158, 簡佳吟
// Date: 2020/12/21 

#include <stdio.h>
#include <stdlib.h>

typedef struct sPoly {	

	int degree;			// the degree of the node 
	double coef;		// the coefficient of the node
	struct sPoly *next;	// pointer to the next node

 }POLY;

POLY *oneterm(int degree, double coef);
	// This function creates a 1-term polynomial of the form coef * X^degree
	// and returns the new polynomial.
POLY *add(POLY *p1, POLY *p2);
	// This function adds two polynomials pq and p2 to form a new polynomial
	// and return the new polynomail.
POLY *sub(POLY *p1, POLY *p2);
	// This function subtracts polynomial p2 from p1 to form a new polynomial
	// and return the new polynomial.
POLY *mply(POLY *p1, POLY *p2);
	// This function multiplies two polynomials p1 and p2 to form a new
	// polynomial and return the new polynomial.
void print(POLY *p1);
	// This function prints out the polynomial p1 in human readable form.
	// See the example output given below foe more details.
void release(POLY *p1);
	// This function releases all node of the polynomial p1 
	// and returns them to the heap space.
int main(void)
{

	POLY *x, *one;					 // x is polynomial x, one is constant 1					
	POLY *A, *A2, *A3, *A4, *A5;
	POLY *B, *B2, *B3, *B4, *B5;
	POLY *C, *C2, *C3, *C4, *C5;
	
	x = oneterm(1, 1);		// creates polynomials
	one = oneterm(0, 1);		
	A = add(x, one);			
	A2 = mply(A ,A);			
	A3 = mply(A2, A);		
	A4 = mply(A3, A);
	A5 = mply(A4, A);

	printf("A =");			// prompt
	print(A);	
	printf("A2 =");
	print(A2);

	B = sub(x, one);		// creates polynomials
	B2 = mply(B, B);
	B3 = mply(B2, B);
	B4 = mply(B3, B);
	B5 = mply(B4, B);

	C = add(A, B);			// creates polynomials
	C2 = mply(A2, B2);
	C3 = mply(A3, B3);
	C4 = mply(A4, B4);
	C5 = mply(A5, B5);

	printf("C = ");			// prompt
	print(C);
	release(A);				// release
	release(B);
	release(C);
	printf("C2 =");			// prompt
	print(C2);
	release(A2);			//release
	release(B2);
	release(C2);
	printf("C3 =");			// prompt
	print(C3);
	release(A3);			// release
	release(B3);
	release(C3);
	printf("C4 =");			// prompt
	print(C4);
	release(A4);			// release
	release(B4);
	release(C4);
	printf("C5 =");			// prompt
	print(C5);
	release(A5);			// release
	release(B5);
	release(C5);

	release(x);				// release
	release(one);

	return 0;
}

// This function creates a 1-term polynomial of the form coef * X^degree
// and returns the new polynomial.
POLY *oneterm(int degree, double coef)
{
	POLY *new_node;

	new_node = (POLY *) malloc(sizeof(POLY));	// creates a space for new_node
	new_node->degree = degree;					// assign degree
	new_node->coef = coef;						// assign coef
	new_node->next = NULL;						// assign next to NULL

	return new_node;							// done and return

}

// This function adds two polynomials pq and p2 to form a new polynomial
// and return the new polynomail.
POLY *add(POLY *p1, POLY *p2)
{
	POLY *first;		// point to the new space
	POLY *s, *t;		// s points to p1, t points to p2
	POLY *new_node;		// for creating new POLY
	int maxdegree;		// the maximum degree of two polynomial
	int coef = 0;		// for suming coef
	int i;				// index for loop

	first = NULL;
	maxdegree = (p1->degree >= p2->degree ? p1->degree : p2->degree);
		// decide the maximum degree of the polynomial to return
	
	for (i = 0; i <= maxdegree; i++) {				// make new nodes
		coef = 0;									// reset coef 
		for (s = p1; s != NULL; s = s->next) {		// p1's coef of degree
			if (s->degree == i) coef += s->coef;	// sum the coef
		}
		for (t = p2; t != NULL; t = t->next) {		// p2's coef of degree
			if (t->degree == i) coef += t->coef;	// sum the coef
		}	
		if (coef != 0 ) {								// creates new_node 
			new_node = (POLY *) malloc(sizeof(POLY)); 	// creates space
			new_node->degree = i;						// assign degree
			new_node->coef = coef;						// assign coef
			new_node->next = first;						// assign next to NULL
			first = new_node;							// let first point to
														// the next new POLY
		}

	}
	
	return new_node;								// done and return

}

// This function subtracts polynomial p2 from p1 to form a new polynomial
// and return the new polynomial.

POLY *sub(POLY *p1, POLY *p2)
{
	POLY *first;    	// point to the new space
	POLY *s, *t;		// s points to p1, t points to p2
	POLY *new_node;		// for creating POLY
	int maxdegree;		// the maximum degree of two polynomial
	int coef = 0;		// for calculating coef
	int i;				// index for loop

	first = NULL;
	maxdegree = (p1->degree >= p2->degree ? p1->degree : p2->degree);
		// decide the maximum degree of the polynomial to return
	
	for (i = 0; i <= maxdegree; i++) {				// make new nodes
		coef = 0;									// reset coef
		for (s = p1; s != NULL; s = s->next) {		// p1's coef of degree
			if (s->degree == i) coef += s->coef;	// calculate the coef
		}
		for (t = p2; t != NULL; t = t->next) {		// p2's coef of degree
			if (t->degree == i) coef -= t->coef;	// calculate the coef
		}	
		if (coef != 0 ) {								// make new nodes
			new_node = (POLY *) malloc(sizeof(POLY)); 	// creates space
			new_node->degree = i;						// assign degree
			new_node->coef = coef;						// assign coef	
			new_node->next = first;						// assign next to NULL
			first = new_node;							// let first point to
														// the next new POLY
		}

	}
	return new_node;								// done and return
}

// This function multiplies two polynomials p1 and p2 to form a new
// polynomial and return the new polynomial.
POLY *mply(POLY *p1, POLY *p2) 
{
	POLY *first;				// point to the new space
	POLY *s, *t;				// s ponits p1, t points to p2
	POLY *new_node;				// for creating new node
	int maxdegree;				// the maximum degree of the polynomial
								// to return
	int coef;					// calculate coef
	int i;						// index for loop

	first = NULL;
	maxdegree = p1->degree + p2->degree;
		// decide the maximum degree of the polynomail to return
	for (i = 0; i <= maxdegree; i++) {				// make new nodes
		coef = 0;									// reset coef
		for (s = p1; s != NULL; s = s->next) {	
			for (t = p2; t != NULL; t = t->next) {
				if (s->degree + t->degree == i) {	
					coef += (s->coef) *(t->coef);	// calculate coef
				}
			} 
		}
		if (coef != 0) {								// make new node
			new_node = (POLY *)malloc(sizeof(POLY));	// create new space
			new_node->degree = i;						// assign degree
			new_node->coef = coef;						// assign coef
			new_node->next = first;						// assign next to NULL
			first = new_node;							// let first point to
														// the new node
		}	
	}
	return new_node;								// done and return
}

// This function prints out the polynomial p1 in human readable form.
// See the example output given below foe more details.
void print(POLY *p1) 
{
	POLY *s;	// point to p1

	for (s = p1; s!= NULL && s->degree >= 1; s = s->next) {
		if (s->coef == 1) printf(" x");					// hide the coef 
		else printf("%g x", s->coef);					// print its coef
		if (s->degree == 1) printf(" ");				// hide its degree
		else printf("^%d ", s->degree);					// print its degree
		if ((s->next) != NULL && (s->next)->coef > 0) printf("+");	// print +
	}
	if (s != NULL && s->coef != 0) printf("%g", s->coef);	// print constant
	printf("\n");											
}

// This function releases all node of the polynomial p1 
// and returns them to the heap space.
void release(POLY *p1)
{
	POLY *s, *first;		

	first = NULL;	
	s = p1;				// let s point to p1
	while (s != NULL) {
		first = s;		// let first point to p1
		s = s->next;	// let s point to s->next
		free(first);	// release the node first points to
	}
}

