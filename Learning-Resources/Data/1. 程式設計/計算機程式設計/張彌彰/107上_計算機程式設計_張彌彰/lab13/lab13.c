/*  EE231002 Lab13. String Encoding
	107061113, 李柏葳
	Date: 2018/12/17
*/

/* The method I use is a little bit lazy, you have to modify 
	code array index if you want scan longer column, the 
	memory allocation method or scan four code at a time I think
	can fix the problem.*/

#include <stdio.h>

int main(void)
{	
	char code[100] = {};					// store encoded letter
	char word[3] = {};						// store decoded letter
	int i;
	
	scanf("%s", code);
	// discard first line
	while( scanf("%s", code) ) {			// scan in current line
		// detect end word
		if (code[0] == 'e' && code[1] == 'n' && code[2] == 'd')	
			return 0;					// return if end of transmission
		for (i = 0; code[i] != '\0'; i++)	// reverse +0x30 process
			code[i] -= 48;
		for (i = 1; code[i] != '\0'; i = i + 4) {	// decode every letter
			word[0] = ( code[i] << 2 ) + ( code[i + 1] >> 4 );
			word[1] = ( code[i + 1] << 4 ) + ( code[i + 2] >> 2 );
			word[2] = ( code[i + 2] << 6 ) + code[i + 3];
			printf("%s", word);						// print out letter
		}
	}

	return 0;										// end in case
}
