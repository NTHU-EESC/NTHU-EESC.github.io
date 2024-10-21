// EE231002 Lab09. Word Processing
// 109061158, 簡佳吟
// Date: 2020/11/30

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char PARA[1500];
int LN = 0;
int LW;

void arrange_title(int i);
void arrange_content(int k);
void print_content(char str[LW], int space);

int main(int argc, char *argv[])
{
	char ch = '0'; 
	int i = 0;
	int count = 0;

	LW = atoi(argv[1]);
	
	while ((ch = getchar()) != EOF){
		i = 0;
		PARA[i] = ch;
		i++;
		while ((ch = getchar()) != '\n') {
			PARA[i++] = ch;
	 	
		}
		for ( ; i < 1500; i++) 	PARA[i] = '\0';

		LN++;
		count++;
		if (count <= 6) arrange_title(count);
		else arrange_content(0);
	}


	return 0;
}

void arrange_title(int i) 
{

	int space;
	int k;
	int m;
	
	for (k = 0; PARA[k] != '\0'; k++) ;
	space = (LW - 3 - k) / 2;
	//if (LN % 5 == 0) printf("%3d", LN);
	//else printf("   ");
	printf("%3d", LN);
	for (m = 0; m < space; m++) printf(" ");
	printf("%s\n", PARA);
	
}

void arrange_content(int k)
{
	printf("***arrange content*** \n ");
	char str[LW];
	int i;
	int space = 0;
	int len;
	
	printf("k1=%d\n", k);
	len = strlen(PARA);
	//printf("%d", len);
	/*if (k > len) {
		printf("end");
		return;
	}*/
	for (i = 0; i < LW - 3; i++) {
	str[i] = PARA[k++];
	}
	str[i] = '\0';
	printf("k2=%d\n", k);

	while (str[--i] != ' ' && i >= 0) {
		str[i] = '\0';
		space++;
		k--;
	}
	printf("k3=%d\n", k);
	//LN++;
//	printf("%d//%d//%d", k, space, LN);
	printf("%s\n", str);
	//if (LN % 5 == 0) printf("%3d", LN);
	//else printf("   ");
	
	arrange_content(k);// error
	
	
		
	
	
		
}

/*int arrange_content(int k)
{
printf("arrange contnet\n");
	char str[LW];
	int i;
	
	int space = 0;

	
	if (PARA[k] == '\0') return 0;
	
	for (i = 0; i < LW - 3; i++) {
		str[i] = PARA[k++];
		//printf("%d//%d", i, k);
	} 
	while (str[i--] != ' ') {
		str[i] = '\0';
		space++;
		k--;
	}
	str[i] = '\0';	
	LN++;	
	if (LN % 5 == 0) printf("%3d", LN);
	else printf("   ");
//	print_content(str, space);
	printf("\n");
//	if (PARA[k] == '\0') return;
	 arrange_content(k+1);
}*/
	

/*void print_content(char str[LW], int space)
{

	int i, j;
	int usedspace;
	int avg;

	if (space == 0) {
		printf("%s", str);
		return;
	}
	for (i = 0; i < LW - 3; i++) {
		if (str[i] == ' ') usedspace++;
	}
	for (i = 0; i < LW - 3;i++) {
		if (str[i] == ' ') {
			avg = space / usedspace;
			for(j = 0; j < avg; j++) {
				printf(" ");
			}
			space -= avg;
			usedspace--;
		}
	
	printf("%c", str[i]);
	}
}*/	

