/* EE231002 Lab10. Academic Competition
   107061113, 李柏葳
   Date: 2018/11/26
*/

#include <stdio.h>

struct STU {					// student info
	char fName[15];				// first name
	char lName[15];				// last name
	double math, sci, lit;		// score of each subject
	double total;				// total score
	double min;					// min score among 3 subject
	int winTotal;				// if win grand prize
	int winSubj;				// if win subject prize
};
struct STU list[100];			// make 100 student's info

void readdata(void);			// get data
void total(void);				// total 3 scores
void min(void);					// get min score of 3 subj.
void wingrand(void);			// output who win grand
void winmath(void);				// who win math
void winsci(void);				// who win science
void winlit(void);				// who win literature
void subjprize0(void);			// reset the subj. prize counter

int main(void)
{	
	int i;
	for (i = 0; i < 100; i++) {	// reset all total prize counter
		list[i].winTotal = 0;
	}
	subjprize0();				// instruction all above
	readdata();					
	total();					
	min();
	wingrand();
	winmath();
	winsci();
	winlit();

	return 0;
}
void readdata(void)				// read in student info
{
	int i;

	while (getchar() != '\n') {};	// discard first line
	for (i = 0; i < 100; i++) {		// scan in 100 students info
		scanf("%s%s%lf%lf%lf", list[i].fName, list[i].lName,
			  &list[i].math, &list[i].sci, &list[i].lit);
	}
	return;
}

void total(void)				// sum their 3 scores
{
	int i;

	for (i = 0; i < 100; i++) {	// sum every student's 3 score in their total
		list[i].total = list[i].math + list[i].sci + list[i].lit;
	}
	return;
}

void min(void)	// get min score of each student
{	
	int i;

	for (i = 0; i < 100; i++) {
		list[i].min = list[i].math;		// set min is math score
		if (list[i].min > list[i].sci) 	// if sci is lower, replace min
			list[i].min = list[i].sci;
		if (list[i].min > list[i].lit) 	// if lit is lower, replace min
			list[i].min = list[i].lit;
	}
	return;
}

void wingrand(void)					// print out grand result
{
	int i,j;
	float max;						// store current max score
	int index = 0;					// store highest score index
	
	printf("Grand Prize:\n");		// print categories
	for (j = 1; j <= 5; j++) {		// get 5 highest
		max = 0;					// reset max value
		for (i = 0; i < 100;i++) {	// find highest score
			if (max < list[i].total && list[i].min >= 80 && 
				list[i].winTotal == 0) {
				// reset max if he not win grand and score higher than max
				max = list[i].total;	// store new score
				index = i;				// get index
			}
		}
		printf("  %d: %s %s %.1lf\n", j, list[index].fName,	// print result
				list[index].lName, list[index].total);
		list[index].winTotal = 1;		// tag student win grand
	}

	return;
}
void winmath(void) 						// print out math result
{
	int i,j;
	float max;
	int index = 0;
	
	printf("Math Prize:\n");
	for (j = 1; j <= 10; j++) {			// print 10 highest math score
		max = 0;
		for (i = 0; i < 100;i++) {		// get max score	
			if (list[i].winTotal == 0 && list[i].winSubj == 0 && 
				list[i].min >= 60 && max < list[i].math) {
				// store max value if he not win grand and math award
				max = list[i].math;		// store max value
				index = i;				// get highest student index
			}
		}
		printf("  %d: %s %s %.1lf\n", j, list[index].fName,	// print result
				list[index].lName, list[index].math);
		list[index].winSubj = 1;		// tag the student get subject award
	}
	subjprize0();						// reset subject tag

	return;
}
void winsci(void)						// print science award winners
{
	int i,j;
	float max;
	int index = 0;						// highest score's index
	
	printf("Science Prize:\n");
	for (j = 1; j <= 10; j++) {			// print top 10 result
		max = 0;
		for (i = 0; i < 100; i++) {		// get new score
			if (list[i].winTotal == 0 && list[i].winSubj == 0 &&
				list[i].min >= 60 && max < list[i].sci) {
				// store max value if he not win grand and sci award
				max = list[i].sci;		// store higher science score
				index = i;				// higher score's index
			}
		}
		printf("  %d: %s %s %.1lf\n", j, list[index].fName,  // print stu score
				list[index].lName, list[index].sci);
		list[index].winSubj = 1;
	}
	subjprize0();						// reset tag if subject done
	return;
}
void winlit(void) 						// print literature result
{
	int i,j;
	float max;
	int index = 0;
	
	printf("Literature Prize:\n");
	for (j = 1; j <= 10; j++) {			// get top10 result
		max = 0;
		for (i = 0; i < 100;i++) {
			if (list[i].winTotal == 0 && list[i].winSubj == 0 && 
				list[i].min >= 60 && max < list[i].lit) {
				// store max value if he not win grand and math award
				max = list[i].lit;		// store higher score
				index = i;				// get higher score's index
			}
		}
		printf("  %d: %s %s %.1lf\n", j, list[index].fName,  // print stu result
				list[index].lName, list[index].lit);
		list[index].winSubj = 1;		// tag win lit prize
	}
	return;
}	

void subjprize0(void) {				// reset subject prize value
	int i;
	for (i = 0;i < 100; i++) {
		list[i].winSubj = 0;
	}
	return;
}
