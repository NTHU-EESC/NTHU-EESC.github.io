/* EE231002 Lab06. Unfriendly knights
   107061113, 李柏葳
   Date: 2018/10/29
*/

/********************************************************
*   Before starting, I want to clarify something.        *
*   The method I am using is backtracking, although      *
*   it is not the most efficiency method, but            *
*   I think is the most appropriate method to            *
*   solve this problem.Because we are engineers          *
*   not mathematician.Mathematician is to get            *
*   the answer by theorem and proof,there is no way      *
*   for us humans to verify all the ways.So it is        *
*   up to computer to verify it,in order to support      *
*   the theorem's correctness.And backtratcking          *
*   is a very useful tools for some type of problems,    *
*   without needing some kind of hypothesis in advance.  *
*   So I want to try it out.                             *
**********************************************************/

#include <stdio.h> // to use standard I/O library

#define N 7  // to setup a NxN board

/* Declaration:In declaration, I mainly setup 3 differentboards,
   first is to place knight on board to try all different methods,
   second is to indicate what block will be attacked with another knight
   third is to store the solution of the answer placement of knight. */
int board[N + 3][N + 3] = {{0}};
int attack[N + 3][N + 3] = {{0}};
int solution[N + 3][N + 3] = {{0}};
int max = 0;    // to remember the highest chess which board can place
int i, j;		// to tick the printing and copying process
int knight = 0; // to count how many knight right now is on the board

void backtracking (int x, int y) {
	if (x >= N + 2) {	// to go to next board line if chess is out of bound
 		y++;		// go to next line
		x = 2;		// reset row number
  	}
	if (y >= N + 2) {	// decide what to do when calculate to bottom
		if (knight > max) {	
			max = knight;
		/* if current knight number is more than previous total max number to 
		place, then replace this number with current number */
			for (i = 2; i <= N + 1; i++){  // copy board placement to solution
				for (j = 2; j <= N + 1; j++){
  					solution[i][j] = board[i][j];
			}
		}
  		return;	// return to previos point where 
		}
	return;
	}
	if (attack[x][y] == 0){	// if this point is not attacked
		board[x][y] = 1;	// place knight on board
		attack[x - 1][y - 2] += 1;	//to indicate which block is attacked
		attack[x - 2][y - 1] += 1;
		attack[x - 2][y + 1] += 1;
		attack[x - 1][y + 2] += 1;
		attack[x + 1][y - 2] += 1;
		attack[x + 2][y - 1] += 1;
		attack[x + 2][y + 1] += 1;
		attack[x + 1][y + 2] += 1;
		knight++;	// count one more knight
		backtracking(x + 1, y);	/* to call out this function again 
		in order to know what to do in next block */
		/* after examine to the bottom the function return
		   start go back to previous spilt point which did not examine */
		knight--;   // to recycle the knight
		board[x][y] = 0;  // to take out knight on this point
		attack[x - 1][y - 2] -= 1;	
		// to update the place where knight do not be attacked anymore
		attack[x - 2][y - 1] -= 1;
		attack[x - 2][y + 1] -= 1;
		attack[x - 1][y + 2] -= 1;
		attack[x + 1][y - 2] -= 1;
		attack[x + 2][y - 1] -= 1;
		attack[x + 2][y + 1] -= 1;
		attack[x + 1][y + 2] -= 1;
	}
   backtracking(x + 1, y);  
   // to go to next block without put knight on the block
}
int main(void) {	
	backtracking(2, 2);  // calculate the max knight and its placement
	printf("Solution with %d knights on a %dx%d board:\n", max, N,  N);
	// print the max knight number and description
	for (i = 2; i <= N + 1; i++) {	// to tick each line
		printf("    ");	// space before print the chess
		for (j = 2; j <= N + 1; j++) { // to convert and print out the board
			if (solution[i][j] == 0) { // what to do with number 0
				printf(" .");
			}
			if (solution[i][j] == 1) { // what to do with number 1
				printf(" o");
			}
		}
		printf("\n");  // go to next line
	}
return 0;  // finally end this program!
}

// I can see why averege coding time is more than 8 hours now.;)
