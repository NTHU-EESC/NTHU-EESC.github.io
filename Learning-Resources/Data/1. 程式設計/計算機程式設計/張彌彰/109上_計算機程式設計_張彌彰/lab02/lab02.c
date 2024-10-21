//EE231002 Lab02 Grouping Digits
//109061158,簡佳吟
//Date 2020/10/5



#include <stdio.h>
int main(void)
{
    int N;                                                 // integer N
    int A;       					   // the leftmost group of digits 
    int B;       					   // the upper class of  middle group of digits
    int C;      					   // the lower class of middle group of digits
    int D;      					   // the rightmost of group od digits

    printf("Input a positive integer N (N<2000000000)");  // print the strings
    scanf("%d", &N); 					  // read the number
    
    A = N / 1000000000;                			 // get the group A
    B = N / 1000000 % 1000;             	         // get the group B
    C = N / 1000 % 1000;               			 // get the group C
    D = N % 1000;                      			 // get the group D
  
    if (N < 1000)
      printf("%.3d\n", D);
    else if (N < 1000000)
      printf("%d,%.3d\n", C, D);
    else if (N <1000000000)
      printf("%d,%.3d,%.3d\n", B ,C, D);
    else 
     printf("%d,%.3d,%.3d,%.3d\n", A, B, C, D);		   // select the group 

   return 0;
}

