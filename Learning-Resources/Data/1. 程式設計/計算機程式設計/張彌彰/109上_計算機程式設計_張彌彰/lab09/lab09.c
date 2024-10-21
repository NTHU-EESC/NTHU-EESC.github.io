// EE231002 Lab09. Word Processing
// 109061158, 簡佳吟
// Date: 2020/11/30

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char PARA[1500];		// array for each paragraph
int LN = 0;				// line number
int LW;					// line width

void arrange_title(void);
	// this function is used to arrange title and print them
	// input: PARA[1500]
	// output: print title
void arrange_content(int k);
	// this function is used to arrange each PARA to a string with
	// width LW
	// input: k(the last situation of PARA of the last call)
	// output: string with width LW
void print_content(char str[LW], int space);
	// this function is used th print each string
	// input: str array
	// output: string with width LW
	
int main(int argc, char *argv[])
{
	char ch = '0'; 						// store each char we get
	int i = 0;							// index for loop
						

	LW = atoi(argv[1]);					// convert char type to int type
	
	while ((ch = getchar()) != EOF){	// read the whole article
		i = 0;							// reset i
		PARA[i] = ch;					// get the first char
		i++;							
		while ((ch = getchar()) != '\n') {	// read each paragraph
			PARA[i++] = ch;					// assign to PARA
	 	
		}
		for ( ; i < 1500; i++) 	PARA[i] = '\0';	// initialize the remaining 
												// unused PARA

		LN++;									// count line number
		if (LN <= 6) arrange_title();			// call function arrange_title
		else arrange_content(0);				// call function arrange_content
	}


	return 0;									// done and return

}

// this function is used to arrange title and print them
// input: PARA[1500]
// output: print title
void arrange_title(void) 
{

	int space;		// number of blank to put in front of each title
	int k;			// index for loop
	int m;			// index for loop
	
	for (k = 0; PARA[k] != '\0'; k++) ;		// count length of each PARA
	space = (LW - 3 - k) / 2;				// assign space
	if (LN % 5 == 0) printf("%3d", LN);		// print LN
	else printf("   ");						// otherwise print 3 space
	printf("%3d", LN);
	for (m = 0; m < space; m++) printf(" ");	// print space to
												//put titlen in the middle
	printf("%s\n", PARA);						// prompt
	
}

// this function is used to arrange each PARA to a string with
// width LW
// input: k(the last situation of PARA of the last call)
// output: string with width LW
void arrange_content(int k)
{
	char str[LW];		// array for arrange PARA
	int i;				// index for loop
	int space = 0;		// count the number should be put extractly
	int len;			// length of each PARA
	
	len = strlen(PARA);				// assaign len
	if (k > len) {					// stop the function
		return;						// there is an error here i have not solved
	}
	for (i = 0; i < LW - 3; i++) {
	str[i] = PARA[k++];					// initialize str array
	}
	str[i] = '\0';						// end the array

	while (str[--i] != ' ' && i >= 0) {		// find blank
		str[i] = '\0';						// end it
		space++;							// count space
		k--;								// decrement k
	}
	if (LN % 5 == 0) printf("%3d", LN);		// print LN 
	else printf("   ");						// otherwise print 3 space
	
	arrange_content(k);						// recurse and do the next str
		
}

// this function is used th print each string
// input: str array
// output: string with width LW
void print_content(char str[LW], int space)
{

	int i, j;				// index for loop
	int usedspace;			// original space in each str
	int avg;				// the average space should put in a string

	if (space == 0) {		// if no other space should put
		printf("%s", str);	// prompt
		return;				// done
	}
	for (i = 0; i < LW - 3; i++) {			// count usedspace
		if (str[i] == ' ') usedspace++;
	}
	for (i = 0; i < LW - 3;i++) {
		if (str[i] == ' ') {
			avg = space / usedspace;		// assign avg
			for(j = 0; j < avg; j++) {
				printf(" ");				// prompt extract space
			}
			space -= avg;					// decrement it when print one other space
			usedspace--;
		}
	
	printf("%c", str[i]);					// prompt
	}
}	

