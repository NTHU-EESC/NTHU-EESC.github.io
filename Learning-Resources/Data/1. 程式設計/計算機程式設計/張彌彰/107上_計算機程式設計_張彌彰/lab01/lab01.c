/*EE231002 Lab01. Typhoon scale
  107061113,李柏葳
  2018/09/17*/
#include<stdio.h>
int main(void)   //function begin
	{
	float mph;  //mile per hour
	float mps;  //meter per second 
	printf("Input speed in miles per hour:");
	//print Input speed in miles per hour:
	scanf("%f",&mph); //input mile per hour
	mps=mph*0.44704;  //calculate typhoon meter per second
	printf("The speed in metric system is %g meters per second.\n",mps);
	//print The speed in metric system is %g meters per second.
	return 0;
	}
