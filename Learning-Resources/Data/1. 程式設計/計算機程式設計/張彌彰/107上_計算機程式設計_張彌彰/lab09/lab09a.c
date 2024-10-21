/* EE231002 Lab09. Word Processing
   107061113, 李柏葳
   Date: 2018/11/19
*/


#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define LSTR 5000

int numword = 0;	// total paragraph word num
int lim;			// limit words per row
char para[LSTR];	// store paragraph

int readLine(char para[]);  // get the input paragraph
void center(char *para);	// put text in the center
void lAlign(char *para);	// put text in left align
void rAlign(char *para);	// put text in right align

int main (int argc, char *argv[]) {
	lim = atoi(argv[1]);		// change type of argv1 to int
	while( readLine(para) ) {	// read in text and detect if it end
		if (*argv[2] == 'c') {	// c for center align
			center(para);
		}
		if (*argv[2] == 'l') {	// l for left align
			lAlign(para);
		}
		if (*argv[2] == 'r') {	// r for right align
			rAlign(para);
		}
	}
	return 0;	// program terminate
}

int readLine(char para[]) {
	int i = 0;		// index of para
	int exit = 1;	// exit scan loop
	char ch;		// store word in para array

	while ( exit && ( ch = getchar() ) != '\n') {	// scan word if \n exit
		para[i++] = ch;				// go to next index after store in
		if ( ch == '.') {			// if the word is .
			if ( ( ch = getchar() ) == ' ' ) {	// and next to a space
				para[i++] = ' ';	// print 2 spaces after .
				para[i++] = ' ';
			}
			else if ( ch == '\n') {	// if \n exit scan
				exit--;
			}
			else para[i++] = ch;	// if non above store it
			}
		}

	para[i] = '\n';		// go to next line after stop
	para[i + 1] = '\0';	// store null character at end
	numword = i + 1;	// total words in paragraph

	if ( strcmp(para,"EOF\n") == 0) {
		return 0;		// stop if last row is EOF/n
	}
	else return 1;		// else pause
}

void lAlign(char *para) {
	int j,k;			// for counting
	int lastspace = 0;	// last space in row
	int counter;		// how many word had processed
	int out = 1;		// get out the search loop

	for (counter = 0; counter <= numword; counter = counter + j + 1) {
		// record current word and stop if on last line 
		for (j = 0; out && j < lim; j++) {		// find if row is end 
			if( *(para + counter + j) == '\n' ) {	// get out loop if find
				out--;
				for (k = counter; k <= counter + j; k++) {	// print row
					printf("%c", *(para + k) );
				}
			}
		}
		if (out) {		// if not find space
			for (j = lim - 1; out && j > 0; j--) {	// find last space in row
				if ( *(para + counter + j)  == ' ') {	// 
					lastspace = counter + j;
					out--;
				}
			}
			for (k = counter; k < lastspace; k++) {	// print row to  last word
				printf("%c", *(para + k) );
			}
		printf("\n");	// print line
		}
		out++;			// reset out
	}
	return;	// go back
}

void center(char *para) {

	int i,j,k;			// to count for loop
	int lastspace = 0;	// count last space in row
	int counter;		// record what word processing now
	int out = 1;		// get out search loop
	int space;			// decide space before print loop

	for (counter = 0; counter <= numword; counter = counter + j + 1) {
		// record how many word processed and stop when all processed
		for (j = 0; out && j < lim; j++) {			// find if it end 
			if( *(para + counter + j) == '\n' ) {	// if end
				out--;
				space = (lim - j) / 2;				// calculate print space
					for ( i = 0;i < space; i++) {	// print spaces
						printf(" ");
					}
				for (k = counter; k <= counter + j; k++) {	// print the row
					printf("%c", *(para + k) );
				}
			}
		}
		if (out) {			// if no /n found
			for (j = lim - 1; out && j > 0; j--) {	// find last space
				if ( *(para + counter + j)  == ' ') {
					lastspace = counter + j;	// store last space index
					out--;
				}
			}
			space = (lim - j - 1) / 2;			// calculate last space
			for ( i = 1;i < space; i++) {		// print spaces
				printf(" ");
			}
			for (k = counter; k < lastspace; k++) {	// print row
				printf("%c", *(para + k) );
			}
		printf("\n");	// print next line
		}
		out++;			// reset out
	}
	return;	// go back
}

void rAlign(char *para) {
	int i,j,k;			// to count
	int lastspace = 0;	// stor last space in row
	int counter;		// record word num processed
	int out = 1;		// go out find loop
	int space;			// calculate space to print

	for (counter = 0; counter <= numword; counter = counter + j + 1) {
		// record how many word had processed and end if all processed 
		for (j = 0; out && j < lim; j++) {	// find space
			if( *(para + counter + j) == '\n' ) {
				out--;
				space = lim - j;			// calculate space to print
					for ( i = 1;i < space; i++) {	// print space
						printf(" ");
					}
				for (k = counter; k <= counter + j; k++) {	// print row
					printf("%c", *(para + k) );
				}
			}
		}
		if (out) {		// if no /n found
			for (j = lim - 1; out && j > 0; j--) {	// find last space in row
				if ( *(para + counter + j)  == ' ') {
					lastspace = counter + j;		// store last space index
					out--;
				}
			}
			space = lim - j;		// calculate space to print
			for ( i = 0;i < space; i++) {	// print space
				printf(" ");
			}
			for (k = counter; k < lastspace; k++) {	// print row
				printf("%c", *(para + k) );
			}
		printf("\n");	// go to next line
		}
		out++;	// reset out
	}
	return;	// go back
}

