// Q4 108061213 劉奕緯
// We have practiced factorizing an positive integer by its prime factors
// and associated powers. For example,
//
// 100 = 2^2 x 5^2
//
// And the NODE defined below is shown to be a good data structure for
// the linked list of the prime factorization.
//

typedef struct sFactor {
    int prime;
    int power;
    struct sFactor *next;
} Factor;

// Given 3 linked lists that represent 3 positive integers, please write
// a function to find the Greatest Common Divider (GCD) of those 3 integers.
// The function returns a linked list of prime factors and their associated
// powers.
#include<stdlib.h>
Factor *GCD3(Factor *A, Factor *B, Factor *C)
{
	Factor *ptra, *ptrb, *ptrc;			// pointer to a, b, c
										// but ptra reuse for the *GCD(a, b)
	Factor *head, *head2, *cur, *pre;	// head for *GCD(a, b) and 
										// *GCD(GCD(a, b), c)

	ptra = A;
	ptrb = B;
	ptrc = C;
	head = NULL;
	head2 = NULL;
	// GCD of A and B;
	while (ptra != NULL) {
		if (ptra->prime == ptrb->prime) {
			cur = malloc(sizeof(Factor));
			cur->prime = ptra->prime;
			if(ptra->power > ptrb->power)
				cur->power = ptrb->power;
			else
				cur->power = ptra->power;
			cur->next = NULL;
			if (head == NULL) head = cur;
			else pre->next = cur;
			pre = cur;
			ptra = ptra->next;
			ptrb = ptrb->next;
		}
		else if (ptra->prime > ptrb->prime)
			ptrb = ptrb->next;
		else
			ptra = ptra->next;
	}
	ptra = head;
	// GCD of (GCD of A and B) and C
	while (ptra != NULL) {
		if (ptra->prime == ptrc->prime) {
			cur = malloc(sizeof(Factor));
			cur->prime = ptra->prime;
			if(ptra->power > ptrc->power)
				cur->power = ptrc->power;
			else
				cur->power = ptra->power;
			cur->next = NULL;
			if (head2 == NULL) head2 = cur;
			else pre->next = cur;
			pre = cur;
			ptra = ptra->next;
			ptrc = ptrc->next;
		}
		else if (ptra->prime > ptrc->prime)
			ptrc = ptrc->next;
		else
			ptra = ptra->next;
	}
	return head2;
}
