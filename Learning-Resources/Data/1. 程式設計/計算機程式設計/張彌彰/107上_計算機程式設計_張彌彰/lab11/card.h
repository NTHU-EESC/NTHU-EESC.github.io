/*
 * Blackjack game
 *    card structure and global info
 *
 */

// this defines how many decks of cards to be used in the game
#define Ndeck 4

enum CARDSUIT { SPADE, HEART, DIAMOND, CLUB, DOWN };
enum CARDVALUE { ACE, TWO, THREE, FOUR, FIVE, SIX, SEVEN, EIGHT, NINE,
                 TEN, JACK, QUEEN, KING, NONE };

struct CARD {	// one card has two properties
	enum CARDSUIT suit;
	enum CARDVALUE value;
};

// some useful functions are also declared here
int card_point_soft(const struct CARD cd);	// this function returns the points
											// of a card, Ace is treated as 1
int card_point_hard(const struct CARD cd);	// this function returns the points
	                                        // of a card, Ace is treated as 11
int with_ace(const struct CARD cards[],const int Ncards);
										// this function check if 
                                        // there is an Ace in the hand
										// 1: yes, 0: no
int sum_cards(const struct CARD cards[],const int Ncards);
										// this function sums the
                                        // hand, returns larger value but
										// not exceeding 21
int is_blackjack(const struct CARD cards[], const int Ncards);
										// this function checks
                                        // if the hand is Blackjack or not
