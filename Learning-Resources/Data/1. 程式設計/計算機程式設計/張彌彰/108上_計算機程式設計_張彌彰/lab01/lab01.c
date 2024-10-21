//EE231002,lab01
//108061213,劉奕緯
//sep.16,2019

#include <stdio.h>

#define lightspeed 299792458

int main (void)
{
	double distance;																// declare type of distance

	printf("Input distance in kilometer: ");										// print the  hint
	scanf("%lf",&distance);                                                         // intput the value of distance
	printf("The minimum response time is %g seconds.\n",distance/lightspeed*2*1000);// output the answer

	return 0;
}




