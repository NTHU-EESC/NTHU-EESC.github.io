// EE231002 Lab03. Day of the Year and Day of the week
// 108061213, 劉奕緯
// Date: Jan. 1, 2020

#include <stdio.h>							// use the standard io library

int main(void)								
{
	int year;								// the year of date
	int month;								// the month of date
	int date;								// the date of the date
	int sum;								// sum of days
	int DoY;								// day of year

	printf("Enter a date (y/m/d):");		// prompt the date
	scanf("%d/%d/%d", &year, &month, &date);// input the date
	sum = date; 							// add up the date
	switch (month) {						// add up the days of past month
		case 12 : sum += 30;
		case 11 : sum += 31;
		case 10 : sum += 30;
		case 9 : sum += 31;
		case 8 : sum += 30;
		case 7 : sum += 31;
		case 6 : sum += 31;
		case 5 : sum += 30;
		case 4 : sum += 31;
		case 3 : sum += 28;
				 if (year % 400 == 0 || (year % 100 != 0 && year % 4 == 0))
				 	sum += 1;
					 						// whether is leap month or not
		case 2 : sum += 31;
	}
	DoY = sum;
	year -= 1;								// get how many years in past
	sum += year / 4 - year / 100 + year / 400 + year * 365;	
											// add up days of past years
	printf("Total Gregorian Calendar days: %d\n", sum); 
											// output sum of days
	printf("Day of year:%d\n", DoY);		// output how many days in this year

	switch (sum % 7) {						// know that 1/1/1 is Sunday
											// and output the day of week
	    case 1 : printf("Day of week: Monday\n"); break;
	    case 2 : printf("Day of week: Tuesday\n"); break;
	    case 3 : printf("Day of week: Wednesday\n"); break;
		case 4 : printf("Day of week: Thursday\n"); break;
	    case 5 : printf("Day of week: Friday\n"); break;
	    case 6 : printf("Day of week: Saturday\n"); break;
	    case 0 : printf("Day of week: Sunday\n"); break;
	}
	return 0;
}
