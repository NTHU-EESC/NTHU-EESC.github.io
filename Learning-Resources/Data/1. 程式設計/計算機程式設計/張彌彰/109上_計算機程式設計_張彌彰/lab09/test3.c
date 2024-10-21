// EE231002 Lab09. Word Processing
// 109061158, 簡佳吟
// Date: 2021/1/2

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char PARA[1500];
int LN = 0;
int LW;

void arrange_title(int i);




int main(int argc, char *argv[1])
{
	char ch;
	int i;

	LW = atoi(argv[1]);

	while ((ch = getchar()) != EOF) {
		i = 0;
		PARA[i] = ch;
		i++;
		while ((ch = getchar()) != '\n') {
			PARA[i++] = ch;
		}
		PARA[i] = '\0';
		LN++;
		if (LN <= 6) arrange_title(LN);
		//else arrange_content(0);
	}



	return 0;
}


void arrange_title(int i) 
{

	int len;
	int space;
	int m;

	len = strlen(PARA);
	space = (LW - 3 - len) / 2;
	if (LN % 5 == 0) printf("%3d", LN);
	else printf("   ");
	for (m = 0; m < space; m++) printf(" ");
	printf("%s\n", PARA);

}

