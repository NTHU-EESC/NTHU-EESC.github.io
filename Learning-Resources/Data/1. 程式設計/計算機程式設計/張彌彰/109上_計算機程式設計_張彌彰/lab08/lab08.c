// EE231002 Lab08. Poker Hands
// 109061158, 簡佳吟
// Date: 2020/11/23


#include <stdio.h>
#include <stdlib.h>
#define N 10000000		// number of total trials

int category(int card[5]);
	// This function categorizes the card,and return numbers represent its type
	// 	input: card[5] 
	// 	output:
	// 	 0 straight flush
	// 	 1 four of a kind
	// 	 2 full house
	//	 3 flush
	// 	 4 straight
	// 	 5 three of a kind
	// 	 6 two pair
	// 	 7 one pair
	// 	 8 high card

int main (void)
{
	int card[5];				// array of card
	int i, k;					// index for loop
	long int j;					// index for loop
	int card_type;				// type of card
	float type[9] = {0};		// count each type
	
	for (j = 1; j < N; j++) {
		for (i = 0; i < 5; i++) {
			 card[i] = (rand() / 1000) % 52;	// shuffle
			for (k = 0; k < i; k++) {
				if (card[k] == card[i]) i--;	// if the card has same number
												// shuffle again
			}
		}
	
		card_type = category(card);				// call category function
		
		switch (card_type) {					// select card type
			case 0: type[0]++; break;			// and count the number
			case 1: type[1]++; break;
			case 2: type[2]++; break;
			case 3: type[3]++; break;
			case 4: type[4]++; break;
			case 5: type[5]++; break;
			case 6: type[6]++; break;
			case 7: type[7]++; break;
			case 8: type[8]++; 
		}

	}

	printf("Categories      Probability\n");					// prompt
	printf("Straight flush    %6.4f%%\n", type[0] / N * 100);	// prompt
	printf("Four of a kind    %6.4f%%\n", type[1] / N * 100);	// and
	printf("Full house        %6.4f%%\n", type[2] / N * 100);	// calculate
	printf("Flush             %6.4f%%\n", type[3] / N * 100);	// probability
	printf("Straight          %6.4f%%\n", type[4] / N * 100);
	printf("Three of a kind   %6.4f%%\n", type[5] / N * 100);
	printf("Two pair          %6.4f%%\n", type[6] / N * 100);
	printf("One pair          %6.3f%%\n", type[7] / N * 100);
	printf("High card         %6.3f%%\n", type[8] / N * 100);
	return 0;												// done and return
}


// This function categorizes the card,and return numbers represent its type
// 	input: card[5] 
// 	output: 0 straight flush
// 		    1 four of a kind
// 		    2 full house
// 		    3 flush
// 		    4 straight
// 		    5 three of a kind
// 		    6 two pair
// 		    7 one pair
// 		    8 high card

int category(int card[5])
{

	int rank[13] = {0};		// array for card's rank
	int suit[4] = {0};		// array for card's suit

	int straight = 0;		// number for scanning whether it is straight
	int flush = 0;			// number for scanning whether it is flush
	int pair = 0; 			// number for scanning whether it has pair
	int three_kind = 0;		// number for scanning
							// whether it has three of a kind
	int four_kind = 0;		// number for scanning
							// whether it is four of a kind

	int i;					// index for loop
	int num_consec = 0;		// number for checking whether it is straight

	for (i = 0; i < 5; i++) {	// initialize rank array
		rank[card[i] % 13]++;	// rank 0 is A and rank 1 is 2,and so on
	}

	for (i = 0; i < 5; i++) {				// card 0 ~ 12 is spade
		if (card[i] < 13) suit[0]++;		// card 13 ~ 25 is heart
		else if (card[i] < 26) suit[1]++;	// card 26 ~ 38 is diamond
		else if (card[i] < 39) suit[2]++;	// card 39 ~ 51 is club
		else  suit[3]++;
	}
												// scan for straight
	for (i = 0; i < 13 && rank[i] == 0; i++) ;	// find the smallest index s.t.
												// rank[i] is not 0
	for (; i < 13 && rank[i] > 0; i++) {
		num_consec++;							// check whether rank[i] to 
												// rank[i + 5] is not 0
	}
	if (num_consec == 5) straight = 1;			// if num_consec is 5
												// is straight


	for (i = 0; i < 4; i++) {					// scan for flush
		if (suit[i] == 5) flush = 1;			// if there exists suit[i] is 5
												// the card has the same suit
	}
	for (i = 0; i < 13; i++) {					// scan for pair,
												// three of a kind,
												// and four of a kind
		if (rank[i] == 2) pair += 1;			// if rank[i] = 2
												// there exists two card 
												// with same value
		if (rank[i] == 3) three_kind = 1;		// if rank[i] = 3, there exists
												// three of a kind
		if (rank[i] == 4) four_kind = 1;		// if rank[i] = 4,
												// is four of a kind
	}

													// select for each type						
	if (straight && flush) return 0;				// straight flush
	else if (four_kind) return 1;					// four of a kind
	else if (three_kind && pair == 1) return 2;		// full house
	else if (flush && !straight) return 3;			// flush
	else if (straight && !flush) return 4;			// straight
	else if (three_kind && pair == 0) return 5;		// three of a kind
	else if (pair == 2) return 6;					// two pair
	else if (pair == 1 && !three_kind) return 7;	// one pair
	else return 8;									// high card
}

