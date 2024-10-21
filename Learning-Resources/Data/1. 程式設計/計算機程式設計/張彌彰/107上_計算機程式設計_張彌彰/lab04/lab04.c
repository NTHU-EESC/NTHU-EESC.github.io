/* EE231002 Lab04, Calender of the Month
   107061113, 李柏葳
   Date: 2018/10/17 */

#include <stdio.h>	// call out standard I/O library

int main (void)		// main function begin
{
	int month;               // declared to storage month input
	int day = 1;             // to count the day of the month
	int numday = 1;			 // to tell computer how many day in this month
	int daysum = 0;			 // to summarize days in the year before this day
	int monthbegin = 1;		 /* to count how many days
								of previous month in this week */
	int weekend = 0;		 // to count when to next line  after 7 days
	printf("Input a month of 2018: ");  // to ask to input month
	scanf("%d", &month);                // to input what month it is
	switch (month) {                    /* tell computer what to print
	                         and how many days in the month */
		case 1: printf("    January 2018\n");
				numday = 31;
				break;
		case 2: printf("    February 2018\n");
				numday = 28;
				break;
		case 3: printf("    March 2018\n");
				numday = 31;
				break;
		case 4: printf("    April 2018\n");
				numday = 30;
				break;
		case 5: printf("    May 2018\n");
				numday = 31;
				break;
		case 6: printf("    June 2018\n");
				numday = 30;
				break;
		case 7: printf("    July 2018\n");
				numday = 31;
				break;
		case 8: printf("    August 2018\n");
				numday = 31;
				break;
		case 9: printf("    September 2018\n");
				numday = 30;
				break;
		case 10: printf("    October 2018\n");
				 numday = 31;
				 break;
		case 11: printf("    November 2018\n");
				 numday = 30;
				 break;
		case 12: printf("    December 2018\n");
				 numday = 31;
				 break;
		default: printf("Input error, program aborts!\n");  
				 break;
				 // ask error if not input number 1-12
		}
	if (month <=12) {        // to restrict perform from 1 to 12
		switch (month) {      /* to know how many days after begin
							     of the year to this month's begin  */
			case 12: daysum += 30;
			case 11: daysum += 31;
			case 10: daysum += 30;
			case 9: daysum += 31;
			case 8: daysum += 31;
			case 7: daysum += 30;
			case 6: daysum += 31;
			case 5: daysum += 30;
			case 4: daysum += 31;
			case 3: daysum += 28;
			case 2: daysum += 31;
			case 1: daysum += 1;
	}
	printf("    Sun Mon Tue Wed Thu Fri Sat\n    "); 
		// print the second line of the calender
	monthbegin = daysum % 7;     // to know what day is the month's 1st day
	while (monthbegin >= 1) {    
		// to count how many day in the week before month's 1st day
		weekend++;    // start to count days in line
		monthbegin--;  // countdown days before 1st
		printf("    ");		// print blanks in those day in previous month
	}
	for (day = 1;day <= numday;day++ ) {	// to start printing day
		if (weekend == 7) {			/*  to go to next line if 
                                        there are 7 days in this line */
			printf("\n    ");		// go to the next line(week)
			weekend -= 7;           // reset the counter of the line
		}
		weekend++;					// make week counter +1
		printf("%2d  ", day);		// print each day on the screen
		}
	printf("\n");                   // go to next line after end of the calender
	}
	return 0;
}


