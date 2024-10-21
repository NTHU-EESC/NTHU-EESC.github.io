/* EE231002, Lab11. Blackjack Strategy
   107061113, 李柏葳
   Date: 2018.12.03
*/

#include <stdio.h>
#include "card.h"

extern int step_display;
extern int Nhands;
int remain[13] = { };			// how many card of value had thrown
int totalcards = 208;			// total card number
float chance[13];				// chance to get each card

char play4_name[7]="me";		// player name

int play4_bet_init(int credit);	
	// places bet for each round of Blackjack game
int play4_hit_or_stand(const struct CARD mycard[],int Nmycard,
	const struct CARD dealercard[],int Ndealercard);
		// determines if you want to hit or stand
void play4_shuffle();
	// reset deal if dealer reshuffles the decks
void play4_deal_one_card(const struct CARD cd);
	// a card is dealt by the dealer

/*  this function places a bet before cards are dealt
	input: the amount of credit left for the user
	output: how much the player want to bet for this round
	algorithm: bet no more than 3	*/
int play4_bet_init(const int credit)
{
	step_display = 0; 		// by turning off this, it speed up the game
	Nhands = 1000; 			// number of hands to be played
	return 10;
}

// this function decides if to hit for more cards or not
// input: player's cards (and number of cards)
// dealer's cards (and number of cards)
// Note, at this time dealer has only one card
// output: 1 to hit; 0 to stand, 2: double (receive only 1 card), 3: surrender
// algorithm: hit if player's points is less than 17

int play4_hit_or_stand(const struct CARD mycard[], int Nmycard,
	const struct CARD dealercard[], int Ndealercard)
{	
	int sum = 0;			// sum of my card value
	int dpower = 1;			// strength of dealer
	int i;
	
	// get the chance to get value of this and before value
	chance[0] = ( 16 - remain[0] ) / (float)totalcards;	
	for (i = 1; i < 13; i++) {
		chance[i] = chance[i - 1] + ( 16 - remain[i] ) / (float)totalcards;
	}
	for (i = 1; i <= 3; i++) {
		chance[9] = chance[9] + chance[9 + i];
	}
	// determine if dealer is strong
	if ( dealercard[0].value >= 2 && dealercard[0].value <= 6) {
		dpower = 0;
	}
	sum = sum_cards(mycard,Nmycard);	// sum hand's value
	if (sum <= 11) 
		return 1;			// draw if sum value <= 11
	else if( dpower && chance[21 - sum] >= 0.3846)  // defensive if dealer weak
		return 1;
	else if( chance[21 - sum] >= 0.615)			// aggresive if dealer strong
		return 1;
	else return 0; 		// if chance of over 21 is too high,stand
}

// this function is called when the cards are reshuffled
void play4_shuffle()
{	
	int i;

	for (i = 0; i <= 12; i++) {	// reset all card value counter
		remain[i] = 0;
	} 
	totalcards = 208;			// reset card left

	return;
}

// this function is called when a card is dealt by the dealer
void play4_deal_one_card(const struct CARD cd)
{
	remain[cd.value]++;			// array of card's value plus 1 if thrown
	totalcards--;				// total card minus 1
	return;
}
