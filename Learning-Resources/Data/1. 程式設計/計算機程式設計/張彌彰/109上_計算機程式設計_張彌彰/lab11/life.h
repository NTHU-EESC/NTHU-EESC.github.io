// life.h
//  define structures, globals, and functions for the game of life program
//

#include <stdio.h>
#include <stdlib.h>

#define N 20

typedef enum {LIVE, DEAD} STATUS;    // enum of cell status
typedef enum {BLACK, GREEN, YELLOW, RED, BLUE, MAGENTA, CYAN, WHITE} COLOR;
									 // available color codes

typedef struct CELLs {
    int row, col;                   // position in the grid
    STATUS current, next;           // status for current and the next pattern
    int age;                        // age of the cell
    COLOR color;                    // color to be shown
    int Nnbr;                       // number of live neighbors
} CELL;

// global variables
extern CELL grid[N][N];             // array for all cells

// function declarations
void readGrid(CELL grid[N][N]);     // read first pattern from stdin
int stillLife(CELL grid[N][N]);     // check if the current pattern is still
void nextGen(CELL grid[N][N]);      // generate the next pattern
void showGrid(int gen,CELL grid[N][N]);    // display the grid on screen
