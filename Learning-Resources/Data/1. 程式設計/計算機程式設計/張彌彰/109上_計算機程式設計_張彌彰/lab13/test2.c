
// EE231002 Lab13. Text Decoding
// 109061158, 簡佳吟
// Date: 2020/12/28

#include <stdio.h>
#include <stdlib.h>
#define N 60

int main(void)
{	
		
	char ch;
	char code[N + 1];
	char word[4];
	int i = 0;
	int j;

	while ((ch = getchar()) != EOF) {
		i = 0;
		while ((ch = getchar()) != '\n') {
			code[i++] = ch - 32;
		}
		code[i] = '\0';
		
		for (j = 0; code[j]; j += 4) {
				word[0] = (code[j] << 2) | (code[j + 1] >> 4);
				word[1] = (code[j + 1] << 4) | (code[j + 2] >> 2);
				word[2] = (code[j + 2] << 6) | (code[j + 3]);
				word[3] = '\0';
				printf("%s", word);
			}
		

		//printf("%s\n", code);
		//printf("\n");
	
		
	
}		
	

	return 0;
}







