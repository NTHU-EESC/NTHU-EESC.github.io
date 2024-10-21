// EE231002 Lab13. Text Decoding
// 109061158, 簡佳吟
// Date: 2020/12/28

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define N 60
int main(void)
{	
	char ch;			// for getting characters
	char code[N + 1];	// store characters per line
	char word[4];		// store decoded character
	int i, j;			// index for loop
	int len;			// length of string

	while ((ch = getchar()) != EOF) {			// read characters 
		i = 0;									// reset i
		while ((ch = getchar()) != '\n') {		
			code[i++] = ch - 32;				// store characters per line
												// and subtract ' '
		}
		code[i] = '\0';							// end string
		len = strlen(code);						// the length of string
		for (j = 0; code[j]; j += 4) {
			word[0] = (code[j] << 2) | (code[j + 1] >> 4);		// decode
			word[1] = (code[j + 1] << 4) | (code[j + 2] >> 2);
			word[2] = (code[j + 2] << 6) | (code[j + 3]);
			word[3] = '\0';										// end string
			if (len != N && word[1] == '\n' && word[2] == ' ') {	
				word[2] = '\0';						// discard the redundant space
			}
			printf("%s", word);					// prompt
		}
	}
	return 0;									// done and return
}
