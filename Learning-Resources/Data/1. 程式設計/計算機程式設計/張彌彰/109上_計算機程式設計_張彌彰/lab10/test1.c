// EE231002 Lab10. Academic Competition
// 109061158, 簡佳吟
// Date: 2020/12/7

#include <stdio.h>
#define N 100

struct STU {				
	char fName[15];			
	char lName[15];	
	double math, sci, lit;
	double total;
};
struct STU list[100];

int main(void) 
{
	char ch; 				// read the first line
	int i, k;				// index for loop
	int serial = 1;			// serial number for each prize
	int grand[N] = {0};		// record the position for Grand Prize winner
	int subject[N] = {0};	// record the position for subject prize candidate
	double max;				// store the maximum
	int top;				// record the posistion of maximum
	int end = 0;			// for stop the loop

	while ((ch = getchar()) != '\n') ;	// read the first line and discard it
	
	for	(i = 0; i < N; i++) {			// scan every line
		scanf("%s %s %lf %lf %lf", list[i].fName, list[i].lName, 
						&list[i].math, &list[i].sci, &list[i].lit);
		
	}


// select who is eligible for Grand Prize or Subject Prize
	for (i = 0; i < N; i++) {			
		if (list[i].math >= 82 && list[i].sci >= 82 && list[i].lit >= 82) {
			list[i].total = list[i].math + list[i].sci + list[i].lit;
			grand[i]++;
		}
		else if (list[i].math >= 60 && list[i].sci >= 60 
					&& list[i].lit >= 60 && !grand[i]) {
			subject[i]++;
		}
	}

// sort Grand Prize winner and prompt
	serial = 1;									// reset serial
	printf("Grand Prize:\n");					// prompt
	for (i = 0; i < N; i++) {					// find the max 
		if (grand[i]) {
			max = list[0].total;				// initialize max
			for (k = 0; k < N; k++) {
				if (list[k].total > max) {
					max = list[k].total;		// store max
					top = k;					// record the position
				}
			}
		
			printf("  %d: %s %s %.1lf\n",serial++, list[top].fName,
						list[top].lName, list[top].total);		// prompt
			list[top].total = 0;								// discard it 
																// and find the
																// next max
		}
	}

// sort Math Prize winner and prompt
	serial = 1;									// reset serial
	printf("Math Prize:\n");					// prompt
	for (i = 0; i < N && !end; i++) {			// find the max
		max = list[0].math;						// initialize max
		for (k = 0; k < N && !end; k++) {
			if (list[k].math > max && subject[k]) {
				max = list[k].math;					// store max
				top = k;							// record the position
			}
			
		}
		printf("  %d: %s %s %.1lf\n",serial++, list[top].fName, 
						list[top].lName, list[top].math);	// prompt
		list[top].math = 0;									// discard it
															// and find the
															// next max
		if (serial > 10) end = 1;							// choose the first 
															// ten people
		
	}

// sort Science Prize winner and prompt
	serial = 1;									// reset serial
	end = 0;									// reset end
	printf("Science Prize:\n");					// prompt
	for (i = 0; i < N && !end; i++) {			// find max
		max = list[0].sci;						// intialize max
		for (k = 0; k < N && !end; k++) {	
			if (list[k].sci > max && subject[k]) {
				max = list[k].sci;				// store max
				top = k;						// record the position
			}
			
		}
		printf("  %d: %s %s %.1lf\n",serial++, list[top].fName, 
						list[top].lName, list[top].sci);	// prompt
		list[top].sci = 0;									// discard it
															// and find the
															// next max
		if (serial > 10) end = 1;							// choose the first
															// ten people
	}

// sort Literature Prize winner and prompt
	serial = 1;								// reset serial
	end = 0;								// reset end
	printf("Literature Prize:\n");			// prompt
	for (i = 0; i < N && !end; i++) {		//find max
		max = list[0].lit;					// initialize max
		for (k = 0; k < N && !end; k++) {
			if (list[k].lit > max && subject[k]) {
				max = list[k].lit;			// store max
				top = k;					// record the position
			}
			
		}
		printf("  %d: %s %s %.1lf\n",serial++, list[top].fName, 
							list[top].lName, list[top].lit);	// prompt
		list[top].lit = 0;										// discard it
																// and find the 
																// next max
		if (serial > 10) end = 1;								// choose the first
																// ten people
		
	}


	return 0;								// done and return
}


