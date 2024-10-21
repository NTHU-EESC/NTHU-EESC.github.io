// EE231002 Lab06. Blackjack probabilities
// 108061213, 劉奕緯
// Date: Oct, 14, 2019

#include<stdio.h>

int main(void)
{
    int cards, suc;							// sum of #cards, # of success 
    int target, play;						// the target point, times we play
    int point, draw;						// total points now, a draw card
    int n;									// # of cards now

    printf("Points Probability #Cards\n");  // the output title
    for (target = 4;target < 22; target++) {	
											// target point from 4 to 21
        suc = cards = 0;					// initialize the # of card & cards
        for (play = 1; play < 100000; play++) {
											// play 100000 times
            point = 0;						// initialize the total points to 0
            draw =  rand() % 13 + 1;		// draw a card
            n = 1;            				// we have one card
            if (draw > 10) point += 10;		// caculate the total points now
            else if (draw == 1 && point < 11) point += 11;
            else point += draw;
            do {      						// draw till exceed or equal
            draw =  rand() % 13 + 1;
			n++;							// we get a card
            if (draw > 10) point += 10;		// caculate the total points now
            else if (draw == 1 && point < 11) point += 11;
            else point += draw;
            } while (point < target);			
            if (point == target) {			// if we got the aimed points
                cards += n;					
                suc++;						// we succeed!
            }
        }
        printf("%3d", target);				// output the result
		printf("%11.2f%%", suc / 1000.0 );	// the success rate in 100000 plays
		printf("%9.2f\n", cards / 1.0 / suc);
											// the average cards to succeed
    }										// aim to another target point
    return 0;
}
