/*  EE231002 Lab03. Consecutive Primes
    107061113, 李柏葳
	Date: 2018/10/8 
*/
# include <stdio.h>     // to call out standard I/O library
int main (void)        // main function begin
{
	int num = 3;       // set main number which being examined is it a prime
	int divide = 2;    // set to examine if num is a prime
	int remain;        // to show the remainder of num/divide
	int prime1 = 0;    // set two primes to print on screen
	int prime2 = 2;
	int exit = 1;      // to decide when this number leave the second loop
	int no = 1;        // number to show on screen after #
	for (num = 3; num <= 600000; num++){        // loop to examine every number
		exit = 1;                              // reset exit
		divide = 2;                            // reset divide
		for (divide = 2; exit == 1; divide++){ /* loop to examine if num is a
	   		 prime or not by divide num to every number from 2 to num/2+1 */
		remain = num % divide;           // to get remainder of num/devide
			if(remain == 0){  // jump to next number if one remainder = 0
			exit = 0;
			}
			else if(divide * divide >= num){ // direct what to do if it is a prime
			prime1 = prime2;  // make previous prime be replaced by new prime
			prime2 = num;
				if(prime2 - prime1 == 2){  /* to check if those 
			        two prime are consecutive primes */
				printf ("Consecutive primes #%d: %d, %d\n"
				, no, prime1, prime2);     //print consecutive primes on the
					// screen with description in the topic
				no++;                      /* to count how many consecutive
					primes on the screen */
				}				
			exit = 0;                      // make prime exit the second loop
			}
		}		
	}		
return 0;                    
}
    

