 #include <stdio.h>
 #include <stdlib.h>


 char PARA[1500];
 int LN = 0;
 int LW;

 void arrange_title(int i);
 int arrange_content(int k);
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
         while (PARA[i] != '\n' && ((ch = getchar()) != '\n')) {
             PARA[i++] = ch;
         }
         PARA[i] = '\0';
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
      if (LN % 5 == 0) printf("%3d", LN);
      else printf("   ");
      for (m = 0; m < space; m++) printf(" ");
      printf("%s\n", PARA);
  }



 int arrange_content(int k)
  {
      char str[LW];
      int i=0;
      int space = 0;
 
      if (PARA[k] == '\0') return 0;
      for (i = 0; i < LW - 3 && k+1<1500; i++) {
          str[i] = PARA[k++];
      }

      while (str[i--] != ' ' && i>=0) {
         str[i+1] = '\0';
         space++;
         k--;
     }
     str[i+1] = '\0';
     LN++;
     if (LN % 5 == 0) printf("%3d", LN);
     else printf("   ");
     print_content(str, space);
     printf("\n");
     arrange_content(k);
 }



void print_content(char str[LW], int space)
 {
     int i, j;
     int usedspace;
     int avg;

     if (space == 0) {
         printf ("%s", str);
         return;
     }
     for (i = 0; i < LW - 3; i++) {
         if (str[i] == ' ') usedspace++;
     }
     for (i = 0; i < LW - 3;i++) {
         if (str[i] == ' ') {
             avg = space / usedspace;
             for(j = 0; j < avg; j++) {
                 printf("  ");
             }
             space -= avg;
             usedspace--;
         }

     printf("%c", str[i]);
     }
 }


