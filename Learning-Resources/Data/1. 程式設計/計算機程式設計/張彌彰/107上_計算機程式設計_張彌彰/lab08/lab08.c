/* EE231002 Lab08.Poker Hands
   107061113, 李柏葳
   Date: 2018/11/12
*/

/****************************************************************************
*    In this program, I think the most important point is to find the       * 
* connection between every catagories.So after some time, I was able to     *
* a solution without sorting to examine cards, which I will explain later.	*
* Also, I have some question in my mind. What is the proper indentation     *
* mean? Is every if statement need {} even if statement just a line?        *
* And how to write perfect comment in the whole program?                    *
* Anyway here is the steps in main function :                               *
* 1) To get 5 different card :                                              *
*	 	First we use rand function to get a number, examine if it was shown *
*	 before, and put it in a small array. After 5 number are chosen, I      *
*    devided random number, the quotient is card's rank,remainder is the    *
*	 card's suit. Yes, I spilt cards into two arraies. Because I thought it *
*	 is more efficiency than a two dimensional array or a long array.       *
* 2) Find categories which at least contain a pair :                        *
*	 	I write a small function in order to examine all 2 cards number		*
*	combinations ( 10 possibilities ) , and see how many possibilities have *
*	the same cards. After finding it. I use a switch function to determine	*
*	what catagories it is.One is a pair, three is three of a kind, four		*
*	is full house, and six is four of a kind.								*
* 3) Find flush :															*
*		This one is simple, just see if next card's suit is same with 		*
*	current one. If yes, it's a flush.										*
* 4) Find straight :														*
*		First, find the biggest card number on the card. And then minus 	*
*	each card with it.then if answer is 10, it's straight. (Note that I		*
*	use if else function so the same card combanations will be filtered 	*
*	out so it did not trigger the function). If cards are both straight 	*
*	and flush, then it's straight flush.									*
* 5) Handle the result:														*
*		All of the result have to turn to percentage, and then print out.	*
*****************************************************************************/

#include <stdio.h>
#include <stdlib.h>

#define totaltry 10000000	// total try number
#define N 5		//number of cards

int rank[N];	// card's rank
int suit[N];	// card's suit
int pair;	// same number pairs

/* to find same number times of possiblities in 5 cards */
int pairs () 
{
	int i,j;

	pair = 0;	// reset counter 
	for (i = 0; i <= N; i++) {		// examine how many pairs
		for (j = i + 1; j <= N; j++) {
			if ( rank[i] == rank[j] )	pair++;
		}
	}
	if ( pair == 0)	// skip same card examines if every card is different
		return 0;
	else
		return 1;
}

	/* to examine if card's suit is same */

int Flush (int suit[]) 
{
	int i;
	for (i = 1; i < N; i++) {	// see if the card suit is same with next one
		if(suit[i] != suit[i + 1]) 
			return 0;	// if not return not
	}

	return 1;	// return yes
}

	/*exam if the card is straight or not */

int Straight ( int exam[])
{
	int i;
	int max = exam[1];	// set number max
	int difference = 0;	// sum of difference between each card and max card

	for( i = 2; i <= N; i++) {	// find largest card
		if (exam [i] > max) {
			max = exam[i];
		}
	}
	for ( i = 1; i <= N; i++) {	// sum all difference of all cards and max 
		difference += max - exam[i];
	}
	if (difference == 10 ) {	// if difference is ten 
		return 1;	// it's a straight
	}
	if (exam[1] == 1 && exam[2] == 10 &&
		exam[3] == 11 && exam[4] == 12 && exam[5] == 13) {
		return 1;	// if it's 1,10,11,12,13 it's a straight
	}

	return 0;	// else return not
}

int main(void) 
{
	int i;	// count in for loops
	int drawnum;	// to count how many cards in hand
	int try = 0;	// current tried number
	int random;		// random number of the card
	int ran[N];		// store random numbers
	int repeated;	// examine if it is repeated
	int totaltrypercent = totaltry / 100;  // make each counter in percentage

    float onepair = 0;		// to count numbers of onepair
	float twopair = 0;		// etc...
	float fullhouse = 0;
	float three_of_a_kind = 0;	// maybe declare int will be faster
	float four_of_a_kind = 0;
	float flush = 0;
	float straight = 0;
	float straightflush = 0;
	float highcard = 0;

	while ( try < totaltry ) {	// count try number
		try++;

		for ( drawnum = 1; drawnum <= N; drawnum++ ) {	//draw cards
			repeated = 0;
			random = rand() / 1000 % 52 + 1;	// get a random number
			for ( i = 1; i < drawnum; i++ ) {
				if(ran[i] == random ) {
					repeated++;	  // if current num is tepeat with previous
				}
			}
			if ( repeated == 0 ) {	// if no repeat store number
				ran[drawnum] = random;
			}
			else drawnum--;		// repeat minus draw number ( redraw )
		}
		for (i = 1;i <= 5;i++) {	// store card number in two types
			suit[i] = ran[i] % 4 + 1;
			rank[i] = ran[i] / 4 + 1;
		}

		if ( pairs() ) {	// if it have pairs 
			switch ( pair ) {	// determine which type it is
				case 1 :	onepair++;
							break;
				case 2 :	twopair++;
							break;
				case 3 :	three_of_a_kind++;
							break;
				case 4 :	fullhouse++;
							break;
				case 6 :	four_of_a_kind++;
			}
		}	
		else if ( Straight(rank) ) {	// is it straight
			if ( Flush(suit) )	// is it flush 
				straightflush++;	// if both, it's straight flush.
			else straight++;	// if not flush, just plus straight
		}
		else if ( Flush(suit))	flush++;	// if flush, flush + 1
		else highcard++;	// if non above, it,s highcard
	}

		/* turn total number into percentage */

	onepair = onepair / totaltrypercent;
	twopair = twopair / totaltrypercent;
	fullhouse = fullhouse / totaltrypercent;
	three_of_a_kind = three_of_a_kind / totaltrypercent;
	four_of_a_kind = four_of_a_kind / totaltrypercent;
	flush = flush / totaltrypercent;
	straight =  straight / totaltrypercent;
	straightflush = straightflush / totaltrypercent;
	highcard = highcard / totaltrypercent;

	/* print outcomes on screen */

	printf("Categories      Probability\n");
	printf("Straight flush   %.4f%%\n", straightflush);
	printf("Four of a kind   %.4f%%\n", four_of_a_kind);
	printf("Full house       %.4f%%\n", fullhouse);
	printf("Flush            %.4f%%\n", flush);
	printf("Straight         %.4f%%\n", straight);
	printf("Three of a kind  %.4f%%\n", three_of_a_kind);
	printf("Two pair         %.4f%%\n", twopair);
	printf("One pair         %.4f%%\n", onepair);
	printf("High card        %.4f%%\n", highcard);


	return 0;	// function terminates
}
