/*  EE231002 Lab12.Polynominals
	107061113, 李柏葳
	Date:2018/12/10
*/

#include <stdio.h>
#include <stdlib.h>

typedef struct sPoly {
int degree; 			// the degree of the node
double coef; 			// the coefficient of the node
struct sPoly *next; 	// pointer to the next node
} POLY;

POLY *X, *One, *a[5], *b[5], *c[5];

POLY *oneTerm(int degree, double coef);
	/*  This function creates a 1-term polynomial of the form
		coefxdegree and returns the new polynomial.	*/
POLY *add(POLY *p1, POLY *p2);
	/*  This function adds two polynomials p1 and p2 to form
		a new polynomial and return the new polynomial. */
POLY *sub(POLY *p1, POLY *p2);
	/*  This function subtract polynomial p2 from p1 to form
		a new polynomial and return the new polynomial.	*/
POLY *mply(POLY *p1, POLY *p2);
	/*	This function multiplies two polynomials p1 and p2 to
		form a new polynomial and return the new polynomial.	*/
void print(POLY *p1, char mode, int num);
	/*  This function prints out the polynomial p1 in human 
		readable form.mode and num is for the print out name 
		of the function.	*/
	/*  NO release function because I do not think it is 
		necessary in this program	*/
int main(void)
{
	int i;
	X = oneTerm(1, 1);
	One = oneTerm(0, 1);
	a[1] = add(X, One);
	b[1] = sub(X, One);
	for (i = 2; i <= 5; i++) {
		a[i] = mply(a[i - 1], a[1]);
		b[i] = mply(b[i - 1], b[1]);
	}
	print(a[1], 'A', 1);
	print(a[2], 'A', 2);
	c[1] = add(a[1],b[1]);
	print(c[1], 'C', 1);
	for (i = 2; i <= 5; i++) {
		c[i] = mply(a[i], b[i]);
		print(c[i], 'C', i);
	}

	return 0;
}

POLY *oneTerm(int degree, double coef)
{
	POLY *new_node;			// temp store struct
	new_node = malloc(sizeof(struct sPoly));	// build new struct
	new_node->degree = degree;		// store degree
	new_node->coef = coef;			// store coef
	new_node->next = NULL;			// set end of a linked list 

	return new_node;				// return one term pointer
}

POLY *add(POLY *p1, POLY *p2)
{	
	POLY *first = NULL;				
	POLY *s,*t;
	int maxdeg;							// to make number of nodes
	int coef = 0;						// calculate coef of the degree
	int i;
	maxdeg = (p1->degree >= p2->degree ? p1->degree : p2->degree);
		// decide maxdegree of the return poly
	POLY *new_node;						// temp store struct
	for (i = 0; i <= maxdeg;i++) {		// loop to make nodes
		coef = 0;						// reset coef calculate
		for (s = p1; s != NULL; s = s->next) {	// p1's coef of the degree
			if (s->degree == i) 
				coef = coef + s->coef;
		}
		for (t = p2;t != NULL; t = t->next) {	// p2's coef of the degree
			if (t->degree == i)
				coef = coef + t->coef;
		}
		if (coef != 0) {				// make node if coef total is not 0
			new_node = malloc(sizeof(struct sPoly));	// get new node
			new_node->degree = i;						// store degree value
			new_node->coef = coef;						// store coef value
			new_node->next = first;			// give pointer point to next node
			first = new_node;				// advance pointer
		}
	}
	return new_node;						// return added pointer
}

POLY *sub(POLY *p1, POLY *p2)
{
	POLY *first = NULL;
	POLY *s,*t;
	int maxdeg;				// store max degree of the function
	int coef = 0;			// to total coef of the degree
	int i;
	maxdeg = (p1->degree >= p2->degree ? p1->degree : p2->degree);	
		// decide max degree of the return poly
	POLY *new_node;			// temp store new node
	for (i = 0; i <= maxdeg; i++) {
		coef = 0;
		for (s = p1; s != NULL; s = s->next) {	// total the coef
			if (s->degree == i)
				coef = coef + s->coef;
		}
		for (t = p2;t != NULL; t = t->next) {
			if (t->degree == i) 
				coef = coef - t->coef;
		}
		if (coef != 0) {						// make new node
			new_node = malloc(sizeof(struct sPoly));
			new_node->degree = i;
			new_node->coef = coef;
			new_node->next = first;
			first = new_node;
		}
	}
	return new_node;
}

POLY *mply(POLY *p1, POLY *p2)
{
	POLY *first = NULL;
	POLY *s,*t;
	int maxdeg = 0;
	int coef = 0;
	int i;
	maxdeg = p1->degree + p2->degree;
		// get max degree
	POLY *new_node;
	for (i = 0; i <= maxdeg; i++) {		// loop to get nodes
		coef = 0;
		// nested loop to make sure sum every coef of degree
		for (s = p1; s != NULL; s = s->next) {		
			for (t = p2;t != NULL; t = t->next) {
				if (t->degree + s->degree == i) 
					coef = coef + ((t->coef) * (s->coef));
						// sum all coef of the degree
			}
		}
		if (coef != 0) {				// make new node
			new_node = malloc(sizeof(struct sPoly));
			new_node->degree = i;
			new_node->coef = coef;
			new_node->next = first;
			first = new_node;
		}
	}
	return new_node;					// return processed poly
}

void print(POLY *p1, char mode, int num) 
{
	POLY *s;
	if(num == 1) 	// print name of poly, if tag is 1, hide
		printf("%c = ", mode);
	else
		printf("%c%d = ", mode, num);
	for (s = p1; s != NULL && s->degree >= 1; s = s->next) {	// print poly
		if (s->coef == 1)				// if coef = 1, hide coef
			printf(" x");
		else	
			printf("%.0lf x",s->coef);	// else print coef
		if (s->degree != 1)				// print degree, if 1, hide.
			printf("^%d ",s->degree);
		else	printf(" ");
		if ((s->next) != NULL && (s->next)->coef > 0)	// print + if coef > 0
			printf("+");
	}
		if (s != NULL && s->coef != 0)	// print constant term
			printf("%.0lf",s->coef);
	printf("\n");						// go to next line
	
	return;
}

