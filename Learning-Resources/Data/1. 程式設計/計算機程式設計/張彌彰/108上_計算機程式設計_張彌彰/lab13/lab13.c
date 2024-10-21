// EE231002 Lab13. Text Decoding
// 108061213, 劉奕緯
// Dec. 19, 2019

#include <stdio.h>				// getchar();  putchar();

// output original text from four number
void Print(unsigned char code[4], int i);
// transfer code to number
unsigned char decoder(unsigned char c);

int main (void) 
{
	unsigned char code[4];		// store encoded texts
	int i = 0;					// #valid code in code[4] array
	char ch;					// buffer for input
	
	// discard first line
	while ((ch = getchar()) != '\n');
	// input the text till find '-'
	while ((ch = getchar()) != '-') {
		if (ch == '=') {		// no more text
			Print(code, i);		// output
			i = 0;				// clear code array
			while (getchar() != '\n');
								// since no more code afterward
		}
		else if ((ch = decoder(ch)) >= 0) {
								// if we obtain a valid code
			code[i++] = ch;		// store it in code array
			if (i == 4) {		// while receiving four codes
				Print(code, i);	// print out the original text
				i = 0;			// clear code array
			}
		}
	}
	// discard the last line and end file
	while ((ch = getchar()) != '\n');
	return 0;
}
// transfer code to number
unsigned char decoder(unsigned char c) 
{
	if ('A' <= c && c <= 'Z')
		return c - 'A';			// 'A' is 0, B is 1, and so on.
	if ('a' <= c && c <= 'z')
		return c - 'a' + 0x1A;	// 'a' is 0x1A, b is 0x1B, and so on.
	if (48 <= c && c <= 57)
		return c - '0' + 0x34;	// '0' is 0x34, '1' is 0x35, and so on.
	if (c == '+')
		return 0x3E;			// given
	if (c == '/')
		return 0x3F;			// given
	return -1;					// invalid code, i assigned it to -1.
}
// output three letters from four codes
void Print(unsigned char code[4], int i) 
{
	unsigned char ascii[3];		// original texts

	if (i == 3) code[3] = 0;	// we have one '='
	if (i == 2) {				// we have two '='
		code[2] = 0;
		code[3] = 0;
	}
	// below three line is recovering split codes back to original texts.
	ascii[0] = (code[0] << 2) | (code[1] >> 4);
	ascii[1] = (code[1] << 4) | (code[2] >> 2);
	ascii[2] = (code[2] << 6) | code[3];
	// output the three original texts
	putchar(ascii[0]);
	if (i > 2)
		putchar(ascii[1]);
	if (i > 3)
		putchar(ascii[2]);
}

