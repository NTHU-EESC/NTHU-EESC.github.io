/* EE231002 Lab09. Word Processing
   107061113, 李柏葳
   Date: 2018/11/19
*/


#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define LSTR 5000

int numword = 0;				// total paragraph word num
int lim;						// limit words per row
char para[LSTR];				// store paragraph

int readLine(char para[]);  	// get the input paragraph
void center(char *para);		// put text in the center
void lAlign(char *para);		// put text in left align
void rAlign(char *para);		// put text in right align

int main (int argc, char *argv[]) {
	lim = atoi(argv[1]);		// change type of argv1 to int
	while( readLine(para) ) {	// read in text and detect if it end
		if (*argv[2] == 'c')	// c for center align
			center(para);
		if (*argv[2] == 'l')	// l for left align
			lAlign(para);
		if (*argv[2] == 'r')	// r for right align
			rAlign(para);
	}

	return 0;					// program terminate
}

int readLine(char para[]) {
	int i = 0;								// index of para
	char ch = '\0';							// store word in para array

	while (ch != '\n') {					// scan paragraph
		ch = getchar();
		para[i++] = ch;						// go to next index after store in
		if (ch == '.') {					// if met .
			if ((ch = getchar()) == ' ') {	// and next is space
				para[i++] = ' ';
				para[i++] = ' ';
			}
			else para[i++] = ch;			// if non above store char
		}
	}

	para[i] = '\0';							// store null character at end
	numword = i;							// total words in paragraph

	if ( strcmp(para,"EOF\n") == 0) {
		return 0;							// stop if last row is EOF/n
	}
	else return 1;							// else pause
}

void lAlign(char *para) {
	int j,k;
	int lastspace = 0;						// last space in row
	int counter;							// how many word had processed

	for (counter = 0; counter < (numword - lim); counter = lastspace + 1) {
		for (j = 0;j < lim ; j++) {				// find last space in row
			if ( para[counter + j]  == ' ')
				lastspace = counter + j;
		}
		for (k = counter; k < lastspace; k++) {	// print row to last word
			printf("%c", para[k]);
		}
		printf("\n");							// go to next line
	}
	for (j = counter; para[j] != '\0'; j++)		// print last line
		printf("%c", para[j]);	
	
	return;										// go back
}

void center(char *para) {
	int j,k;
	int lastspace = 0;						// last space in row
	int counter;							// how many word had processed
	int end = 1;							// see if string end

	for (counter = 0; counter < numword; counter = lastspace + 1) {
		for (j = 0;j < lim && end; j++) {
			if (para[counter + j] == '\0') {	// find end of line
				end--;
				lastspace = counter + j - 1;
			}
			if (para[counter + j]  == ' ')		// find last word end
				lastspace = counter + j;
		}
		for (k = 0; k < (lim + counter - lastspace) / 2; k++)	// print space
			printf(" ");
		for (k = counter; k < lastspace; k++) {	// print row to last word
			printf("%c", para[k]);
		}
		printf("\n");							// go to next line
	}

	return;										// go back
}

void rAlign(char *para) {
	int j,k;
	int lastspace = 0;						// last space in row
	int counter;							// how many word had processed
	int end = 1;							// see if string is end

	for (counter = 0; counter < numword; counter = lastspace + 1) {
		for (j = 0;j < lim && end; j++) {
			if (para[counter + j] == '\0') {		// count to end of string
				end--;
				lastspace = counter + j - 1;
			}
			if (para[counter + j]  == ' ') 			// count space
				lastspace = counter + j;
		}
		for (k = 0; k < (lim + counter - lastspace); k++) 	// print space
			printf(" ");
		for (k = counter; k < lastspace; k++) {		// print row to last word
			printf("%c", para[k]);
		}
		printf("\n");								// go next line
	}

	return;											// go back
}

