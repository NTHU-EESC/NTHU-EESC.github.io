// Q3 109061158 簡佳吟
// Suppose a polynomial, p1, has been constructed using the structure below,
// please write a function to find the value of p1 when x = y.
// Note that p1 is assumed to be not NULL.
//
// For example, if p1 = x^3 + x + 1
//             then the function eval(p1, 2.0) returns 11.0.
//
typedef struct sPoly {
    int degree;                         // the degree of the node
    double coef;                        // the coefficient of the node
    struct sPoly *next;                 // pointer to the next node
} POLY;

double eval(POLY *p1, double y)
{
	POLY *s;			// point to p1
	int i;				// index for loop
	int fact;			// y ^ degree
	int sum = 0;		// sum the coef * fact

	for (s = p1; s != NULL; s = s->next) {
		fact = 1;								// reset fact
		for (i = 0; i < s->degree; i++) {
			fact *= y;							// calculate fact
		}
		sum += s->coef * fact;					// sum the result
	}

	return sum;									// done and return
}



