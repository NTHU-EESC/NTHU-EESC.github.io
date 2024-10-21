/* EE231002 Lab02. Roman Numerials
   107061113, 李柏葳
   Date:2018/10/1 */
#include <stdio.h>      // to call out standard I/O library

int main(void){         // function begin
	int num;            // set num=what decimal number user type in
	int th, hund, ten;  // set 3 variables which represent digits
	printf("Input an integer number between 1 and 3000: ");
	                 	// print Input an integer number between 1 and 3000: 
	scanf("%d", &num);  // scan decimal number which user types in
	th=num/1000;        /* make system identify digit in thousands by
                       	divide 1000 into number */          
	switch(th){         /* command what roman numerals should system print
                    	and minus what number with each digit in thousands */
		case 3: printf("MMM");       // print MMM on the screen
		        num = num - 3000; break; // to make digit in thousands becomes 0
		case 2: printf("MM");        // print MM on the screen
		        num = num - 2000; break; // to make digit in thousands becomes 0
		case 1: printf("M");         // print M on the screen
				num = num - 1000; break; // to make digit in thousands becomes 0
		}
	hund = num / 100;   /* make system identify digit in hundreds by
                        divide 100 into new number */          
	switch(hund){       /* command what roman numerals should system print
                     	and minus what number with each digit in hundreds */
		case 9: printf("CM");        // print CM on the screen
				num = num - 900; break;  // to make digit in hundards becomes 0
		case 8: printf("DCCC");      // print DCCC on the screen
				num = num - 800; break;  // to make digit in hundards becomes 0
		case 7: printf("DCC");       // print DCC on the screen
				num = num - 700; break;  // to make digit in hundards becomes 0
		case 6: printf("DC");        // print DC on the screen
				num = num - 600; break;  // to make digit in hundards becomes 0
		case 5: printf("D");         // print D on the screen
				num = num - 500; break;  // to make digit in hundards becomes 0
		case 4: printf("CD");        // print CD on the screen
				num = num - 400; break;  // to make digit in hundards becomes 0
		case 3: printf("CCC");       // print CCC on the screen
				num = num - 300; break;  // to make digit in hundards becomes 0
		case 2: printf("CC");        // print CC on the screen
				num = num - 200; break;  // to make digit in hundards becomes 0
		case 1: printf("C");         // print C on the screen
				num = num - 100; break;  // to make digit in hundards becomes 0
	     }
	ten = num / 10;         /* make system identify digit in tens by
                       	divide 10 into new number */          
    switch(ten){        /* command what roman numerals should system print
	                    and minus what number with each digit in tens */
		case 9: printf("XC");        // print XC on the screen
				num = num - 90; break;   // to make digit in tens becomes zero
		case 8: printf("LXXX");      // print LXXX on the screen
				num = num - 80; break;   // to make digit in tens becomes zero
		case 7: printf("LXX");       // print LXX on the screen
				num = num - 70; break;   // to make digit in tens becomes zero
		case 6: printf("LX");        // print LX on the screen
				num = num - 60; break;   // to make digit in tens becomes zero
		case 5: printf("L");         // print L on the screen
				num = num - 50; break;   // to make digit in tens becomes zero
		case 4: printf("XL");        // print XL on the screen
				num = num - 40; break;   // to make digit in tens becomes zero
		case 3: printf("XXX");       // print XXX on the screen
				num = num - 30; break;   // to make digit in tens becomes zero
		case 2: printf("XX");        // print XX on the screen
				num = num - 20; break;   // to make digit in tens becomes zero
		case 1: printf("X");         // print X on the screen
				num = num - 10; break;   // to make digit in tens becomes zero
			}         
	switch(num){        /* command what roman numerals should system print
                        with each digit in ones */
		case 9: printf("IX");        // print IX on the screen
				break;
		case 8: printf("VIII");      // print VIII on the screen
				break;
		case 7: printf("VII");       // print VII on the screen
				break;
		case 6: printf("VI");        // print VI on the screen
				break;      
		case 5: printf("V");         // print V on the screen
				break;
		case 4: printf("IV");        // print IV on the screen
				break;
		case 3: printf("III");       // print III on the screen
				break;
		case 2: printf("II");        // print II on the screen
				break;
		case 1: printf("I");         // print I on the screen
				break;
		}
	printf("\n");                    // To go to next line
	return 0;
}
