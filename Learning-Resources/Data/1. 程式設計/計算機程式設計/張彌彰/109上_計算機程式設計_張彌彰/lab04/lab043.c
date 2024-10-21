// EE231002



#include <stdio.h>
#define Max 5000

int main (void)
{
 int a, b, n, i=0;
 for(n=1;n<=Max;n++){
 	if(n%2==0 || n%4==1) {
		for(a=1;a<=71;a++){
			for(b=a; b<=71;b++){
				if(a*a+b*b==n){
					i++;
					printf("%d:%d^3=%d^2+%d^2\n",i, n, a*(a*a+b*b), b*(a*a+b*b));
					a=72;
					b=72;
				
				}
			
			}
		
		
		}
	
	
	
	}
	}

	printf("%d solutions found for n <= Max\n", i);

	return 0;

}






































