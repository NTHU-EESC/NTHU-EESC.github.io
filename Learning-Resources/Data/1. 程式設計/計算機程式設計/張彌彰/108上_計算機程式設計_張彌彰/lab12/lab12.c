// EE231002, Lab12 Linked Lists
// 108061213, 劉奕緯
// Dec. 10, 2019

#include <stdio.h>			// use printf
#include <stdlib.h>			// use malloc, free, atoi
#include <math.h> 			// use pow function

typedef struct factor {		// node for a prime factor
	int prime;				// prime number
	int power;				// associated power	
	struct factor *next;	// pointer for the next prime factor
} FACTOR;

// factorize N into its prime factors and return a linked list 
// that contains all these prime factors.
FACTOR *factorize(int N);	
// This function takes two linked lists of prime factors as input, and 
// finds the Greatest Common Divisor of these two inputs. 
// Note that it returns a linked list of prime factors.
FACTOR *GCD(FACTOR *A, FACTOR *B);
// This function takes two linked lists of prime factors as input, 
// and finds the Least Common Multiple of these two inputs. 
// Note that it also returns a linked list of prime factors.
FACTOR *LCM(FACTOR *A, FACTOR *B);
// This function prints out all the prime factors and their associated powers. 
// In addition, it recalculates the product of all the factors 
// and prints out at the end.
void write(FACTOR *A);
// free a linked list
void FreeList(FACTOR *head);

int main (int arg, char **argv)
{	
	// test
	FACTOR *a, *b, *c; 				// pointer to each linked list
	printf("A = ");					// output A's factorization
	a = factorize(atoi(argv[1]));
	write(a);
	printf("B = ");					// output B's factorization
	b = factorize(atoi(argv[2]));
	write(b);
	printf("GCD = ");
	c = GCD(a, b);					// perform GCD(A,B) 
	write(c);						// and output the result
	free(c);						// free the space GCD(A,B) taken
	printf("LCM = ");				
	write(LCM(a, b));				// perform LCM(A,B) and output the result
	return 0;
}
// factorize N into its prime factors and return a linked list 
// that contains all these prime factors.
FACTOR *factorize(int N)	
{	
	int i, j;						// loop index, i for factor, j for power
	FACTOR *head = NULL;			// pointer to the first linkde list node 
	FACTOR *cur, *pre;				// current node, previous node

	for (i = 2;i <= N;i++) {		// seaching factor
		if (N % i == 0) {			// if i is factor
			for (j = 0; (N % i) == 0; j++) N /= i;
									// then j is corrosponding power
			cur = malloc(sizeof(FACTOR));
									// as a space for new node and cur 
									// point to the memeory
			cur->power = j;			// store into value into node
			cur->prime = i;
			cur->next = NULL;		// this is latest node, i store it in the 
									// end of linklist.
			if (head == NULL) head = pre = cur;
			else pre->next = cur;
									// previous node->next point to cur node
			pre = cur;				// current is previous now.
									// Note that the following method to create
									// a linked list are by the same means.
		}
	}
	return head;
}
// This function prints out all the prime factors and their associated powers. 
// In addition, it recalculates the product of all the factors 
// and prints out at the end.
void write(FACTOR *A)
{
	FACTOR *cur;					// current node
	int product = 1;				// totoal product

	cur = A;						// cur is the first node
	if (cur->power == 1) printf("%d ",cur->prime);
									// we dont print "^1".
	else printf("%d^%d ", cur->prime, cur->power);
	product *= pow(cur->prime, cur->power);
									// caculate the product
	cur = cur->next;				// next node
	while (cur != NULL) {			// print out all list by same means above
		if (cur->power == 1) printf("* %d ",cur->prime);
		else printf("* %d^%d ", cur->prime, cur->power);
		product *= pow(cur->prime, cur->power);
		cur = cur->next;
	}
	printf("= %d\n", product);
}
// This function takes two linked lists of prime factors as input, and 
// finds the Greatest Common Divisor of these two inputs. 
// Note that it returns a linked list of prime factors.
FACTOR *GCD(FACTOR *A, FACTOR *B)
{
	FACTOR *head = NULL;			// pointer to first node
	FACTOR *pre, *cur;				// pointer to previous and current node

	while (A != NULL && B != NULL) {	
									// if they are not equal, Make them equal
		if (A->prime > B->prime) B = B->next;
		else if (A->prime < B->prime) A = A->next;
		else {						// if they equal store the prime and the
									// smaller power.
			cur = malloc(sizeof(FACTOR));
			cur->next = NULL;
			cur->prime = A->prime;
			if(A->power > B->power)	cur->power = B->power;
			else cur->power = A->power;
			if (head == NULL) head = pre = cur;
			else pre->next = cur;
			pre = cur;
			A = A->next;			// next A's 
			B = B->next;			// next B's
		}
	}								// end till a list has no common factor
	if (head == NULL) {				// if they have no common factor
									// then there greatest common factor is 1
		head = malloc(sizeof(FACTOR));
		head->next = NULL;
		head->prime = head->power = 1;
	}
	return head;
}
// This function takes two linked lists of prime factors as input, 
// and finds the Least Common Multiple of these two inputs. 
// Note that it also returns a linked list of prime factors.
FACTOR *LCM(FACTOR *A, FACTOR *B)
{
	FACTOR *head = NULL;			// pointer to first node
	FACTOR *cur, *pre;				// pointer to current and previous nodes

	while (A != NULL && B != NULL) {
		if (A->prime < B->prime) {	// store the smaller factor and its power
			cur = malloc(sizeof(FACTOR));
			cur->next = NULL;
			cur->prime = A->prime;
			cur->power = A->power;
			if (head == NULL) head = pre = cur;
			else pre->next = cur;
			A = A->next;			// next factor
			pre = cur;
		}
		else if (A->prime > B->prime) {
									// store the smaller factor and its power
			cur = malloc(sizeof(FACTOR));
			cur->next = NULL;
			cur->prime = B->prime;
			cur->power = B->power;
			if (head == NULL) head = pre = cur;
			else pre->next = cur;
			pre = cur;
			B = B->next;
		}
		else {						// if they have common factor then store 
									// then store the larger power.
			cur = malloc(sizeof(FACTOR));
			cur->next = NULL;
			cur->prime = B->prime;
			if(A->power > B->power) cur->power = A->power;
			else cur->power = B->power;
			if (head == NULL) head = pre = cur;
			else pre->next = cur;
			pre = cur;
			A = A->next;			// next A
			B = B->next;			// next B
		}
	}
	// if we got all factor of one number
	// then get all remain factor of the other number
	while (B != NULL) {
		cur = malloc(sizeof(FACTOR));
		cur->next = NULL;
		cur->prime = B->prime;
		cur->power = B->power;
		pre->next = cur;
			pre = cur;
		B = B->next;
	}
	while (A != NULL) {
		cur = malloc(sizeof(FACTOR));
		cur->next = NULL;
		cur->prime = A->prime;
		cur->power = A->power;
		pre->next = cur;
			pre = cur;
		A = A->next;
	}
	return head;
}
// delet linked list
void FreeList(FACTOR *head)
{	
	FACTOR *cur, *next;				// current node, next node

	while (cur != NULL) {
		next = cur->next;			// store the address to the next node
		free(cur);					// free up current node
		cur = next;					// go to next node
	}
}
