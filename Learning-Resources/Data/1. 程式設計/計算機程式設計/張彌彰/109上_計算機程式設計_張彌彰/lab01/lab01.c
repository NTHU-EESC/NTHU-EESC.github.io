//EE231002 Lab01 Purchasing Petroleum
// 109061158,Chia-yin Chien
// 2020.09.21


#include <stdio.h>

int main(void)
{	
    int NTD;                            //NT dollars one has.
    float USD;                          //US dollars one has.
 
    float GallonTW;                   //Petroleum in gallon
 				       // one can buy in TW.
 				         
    float LiterTW;                    //Petroleum in liter
				      //one can buy in TW.
				 
    float GallonUS;                   //Petroleum in gallon 
                                      //one can buy in the US.
                                    
    float LiterUS;                    //Petroleum in liter
                                      // one can buy in the US.
    printf("Input NTD amount: ");
    scanf("%d", &NTD);                //Scan the number. 
 
    USD = NTD / 29.02;                //Convert NTD into USD.
   
    LiterTW = NTD / 23.5;             //The liters of petroleum 
                                      //one can buy in TW.
    
    GallonTW = LiterTW / 3.785;        //The gallons of petroleum 
			              //one can buy in the TW.
			         	
    GallonUS = USD / 2.525;            //The gallons of petroleum
                                       //one can buy in the US.

    LiterUS = GallonUS * 3.785;        //The liters of petroleum 
                                       //one can buy in the US.




    printf("Petroleum bought in Taiwan: ");
    printf("%f liters or ", LiterTW);
    printf("%f gallons.\n", GallonTW);   //The result.
   
    printf("Petroleum bought in US: ");
    printf("%f liters or ", LiterUS);
    printf("%f gallons.\n", GallonUS);   //The result.
    return 0;                            //Done and return.
 }  

