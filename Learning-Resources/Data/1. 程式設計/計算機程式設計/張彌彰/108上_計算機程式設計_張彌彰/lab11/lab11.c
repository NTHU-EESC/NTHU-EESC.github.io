// EE231002 Lab11. Academic Competition
// 108061213, 劉奕緯
// Dec. 6, 2019

#include <stdio.h>
#define N 100 									// 100 students

struct STU {									// structure definition for each students
	char fName[15];								// first name
	char lName[15];								// last name 
	double math, sci, lit;						// test scores
	double total;								// total score
};
struct STU list[N];

int main(void)
{
	int i, j, top;								// index, index, the top one
	int g = 0;		 							// #people get grandprize
	int grand[N];								// who gets the grandprize
	int s = 0; 									// #people can get subprize
	int subject[N], ssubject[N];				// who can gets subjectprize

	// discard first line
	while ((i = getchar()) != '\n') ;
	// input data
	for (i = 0; i < N; i++) {
		scanf("%s%s%lf%lf%lf", list[i].fName, list[i].lName, 
						    	&list[i].math, &list[i].sci, &list[i].lit);
	}
	// define who could win SubjectPrize and who win Grandprize
	for (i = 0; i < N; i++) {
		if (list[i].math >= 80 && list[i].sci >= 80 && list[i].lit >= 80) {
			grand[g++] = i;						// i have eligibility 
												// for GrandPrize
			list[i].total = list[i].math + list[i].sci + list[i].lit;
		}
		else if (list[i].math >= 60 && list[i].sci >= 60 && list[i].lit >= 60) 
		{
			subject[s] = ssubject[s] = i;		// i have eligibility 
												// for SubjectPrize
			s++;
		}
	}
	// output Grandprize
	printf("Grand Prize:\n");
	for (i = g - 1; i >= 0; i--) {				// output all in grand list
		top = i;
		for (j = 0; j < i; j++) 				// find the top
			if (list[grand[top]].total < list[grand[j]].total) top = j;
		printf("%3d: %s %s %.1lf\n", g - i, list[grand[top]].fName,
				list[grand[top]].lName, list[grand[top]].total);
		grand[top] = grand[i];					// discard the top one
	}
	// output Math Prize
	printf("Math Prize:\n");
	for (i = s - 1; i >= s - 10; i--) {			// total output 10 people
		top = i;
		for (j = 0; j < i; j++) 				// find the top one 
			if (list[subject[top]].math < list[subject[j]].math) top = j;
		printf("%3d: %s %s %.1lf\n", s - i, list[subject[top]].fName,
				list[subject[top]].lName, list[subject[top]].math);
		subject[top] = subject[i];				// discard the top one 
	}
	for (i = 0; i < s; i++) 
		subject[i] = ssubject[i];				// recover origin data
	// output Science Prize
	printf("Science Prize:\n");
	for (i = s - 1; i >= s - 10; i--) {			// total output 10 people
		top = i;
		for (j = 0; j < i; j++) 				// find the top one
			if (list[subject[top]].sci < list[subject[j]].sci) top = j;
		printf("%3d: %s %s %.1lf\n", s - i, list[subject[top]].fName,
				list[subject[top]].lName, list[subject[top]].sci);
		subject[top] = subject[i];				// discard the top one
	}
	for (i = 0; i < s; i++) 
		subject[i] = ssubject[i];				// recover origin data
	// output Literature Prize
	printf("Literature Prize:\n");	
	for (i = s - 1; i >= s -10; i--) {			// total output 10 people
		top = i;
		for (j = 0; j < i; j++) 				// find the top one
			if (list[subject[top]].lit < list[subject[j]].lit) top = j;
		printf("%3d: %s %s %.1lf\n", s - i, list[subject[top]].fName,
				list[subject[top]].lName, list[subject[top]].lit);
		subject[top] = subject[i];				// discard the top one
	}
	return 0;
}
