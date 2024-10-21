// Q4 u107061113 李柏葳
// A polynomial can be represented by a linked list using the following
// structure for a term of a polynomial. As before, we assume the polynomials
// are arranged in degree descending order.

typedef struct sPoly {
    int degree;             // the degree of a term
    double coef;            // the coefficient of a term
    struct sPoly * next;    // pointer to the next term
} POLY;

// Given two polynomials, P1(x) and P2(x), once the variable x is known
// their values can be calculated. Please write a C function to compare
// the values of P1(x) and P2(x).
//
// For example, if P1(x) = x^2 +2 x +1
//             and P2(x) = x^3 +3 x^2 +3 x + 1
// then P1(1.0) = 4.0, and P2(1.0) = 8.0,
// and  GreaterThan(P1, P2, 1.0) returns 0,
// but  GreaterThan(P2, P1, 1.0) returns 1.

int GreaterThan(POLY *P1, POLY *P2, double x)
{	
	int i;
	double num;
	double p1 = 0;
	double p2 = 0;
	POLY *s;

	for (s = P1; s != NULL; s = P1->next) {
		num = 1;
		for (i = 0; i < s->degree; i++)
			num *= x;
		p1 += coef * num;
	}
	for (s = P2; s != NULL; s = P2->next) {
		num = 1;
		for (i = 0; i < s->degree; i++)
			num *= x;
		p2 += coef * num;
	}

	return p1 > p2 ? 1 : 0;
}
