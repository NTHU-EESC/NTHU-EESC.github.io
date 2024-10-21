// EE231002 Lab03 Day of the Year
// 109061158, 簡佳吟
// Date: 2020/10/12


#include <stdio.h>
int main(void)
{
    int month;       // the month
    int day;         // the day
    int day_year;    // day of the year
    int week_year;   // week of the year
    int day_week;    // day of the week
    
    printf("Input a date (m/d): ");                        // print the string
    scanf("%d/%d", &month, &day);                          // read the number
   

    switch (month) {
        case 1: day_year = day;                           // store day_year
                break;                                    // jump 
        case 2: day_year = day + 31;                      // store day_year
		break;                                    // jump 
        case 3: day_year = day + 60;                      // store day_year
		break;                                    // jump
        case 4: day_year = day + 91;                      // store day_year
		break;                                    // jump
        case 5: day_year = day + 121;                     // store day_year
		break;                                    // jump  
        case 6: day_year = day + 152;                     // store day_year
		break;                                    // jump
        case 7: day_year = day + 182;                     // store day_year 
		break;                                    // jump
        case 9: day_year = day + 244;                     // store day_year
		break;                                    // jump
        case 10: day_year = day + 274;                    // store day_year 
	         break;                                   // jump
        case 11: day_year = day + 305;                    // store day_year
		 break;                                   // jump
        case 12: day_year = day + 335;                    // store day_year
		 break;                                   // jump
        }  
               
    week_year = (day_year + 2) / 7 + 1;                   // store week_year
    printf("It is the day %d of the year,\n", day_year);   // prompt
    printf("in the week of %d of the year,\n", week_year); // prompt
    
    day_week = day_year % 7;                              // store day_week        

    switch (day_week) {
        case 0: printf("and it is Tuesday.\n");   break;      
        case 1: printf("and it is Wednesday.\n"); break;     
        case 2: printf("and it is Thursday.\n");  break;     
        case 3: printf("and it is Friday.\n");    break;     
        case 4: printf("and it is Saturday.\n");  break;     
        case 5: printf("and it is Sunday.\n");    break;     
        case 6: printf("and it is Monday.\n");    break;  // prompt
    }
    return 0;                                             // done and return
}     

            
         

