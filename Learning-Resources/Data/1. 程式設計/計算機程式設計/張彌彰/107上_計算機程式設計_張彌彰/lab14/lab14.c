/*  EE231002 Lab14. Image Processing
	107061113, 李柏葳
	Date: 2018/12/24
*/

/* I have already compile three times after finishing my comments
   but for some reason my computer can compile it normal, and without
   getting a wrong output. So I don't know my corresponding type is 
   wrong. */


#include <stdio.h>
#include <stdlib.h>

typedef struct sPIXEL {         // a single pixel
    unsigned char r, g, b;      // three color components
} PIXEL;

typedef struct sIMG {       // an image of PPM style
    char header[3];         // header, either P3 or P6
    int W, H;               // width and height of the image
    int level;              // intensity level of each color component
    PIXEL **PX;             // two-dimensional array for all the pixels
} IMG;

IMG *PPMin(char *inFile);
	/* This function opens the inFile, reads the image data and returns a 
	pointer pointing to the newly created image data structure. */
void PPMout(IMG *p1, char *outFile);
	// This function writes the image pointed by p1 to the output file outFile.
IMG *PPMcvt(IMG *p1, IMG *ee, IMG *nthu);
	/* This function processes the image pointed by p1 performing the 
	modifications stated above and returns the new image as a result.	*/

int main (int argc, char *argv[]) 
{
	IMG *file1, *file2, *file3, *imgout; // 3 file store input onr for out
	file1 = PPMin(argv[1]);				 // scan in file pic
	file2 = PPMin(argv[2]);
	file3 = PPMin(argv[3]);
	imgout = PPMcvt(file1, file2, file3); // convert pic
	PPMout(imgout, argv[4]);			  // output pic
	return 0;
}

IMG *PPMin(char *inFile)
{
	FILE *fin;							// input file pointer
	IMG *pic;							// temp store image
	int i,j;

	pic = malloc(sizeof(IMG));			// alloc space for image
	fin = fopen(inFile,"r");			// read input file
	fscanf(fin, "%s", pic->header);		// scan in header
	fscanf(fin, "%d %d\n%d\n", &pic->W, &pic->H, &pic->level);
		// scan in width, height, level
	pic->PX = (PIXEL **)malloc(pic->W * sizeof(int *));	// alloc space to pixel
	for (i = 0; i < pic->W; i++)
		pic->PX[i] = (PIXEL *)malloc(pic->H * sizeof(PIXEL));
	for (j = 0; j < pic->H; j++) {						// read in pixel color
		for (i = 0; i < pic->W; i++) {
			pic->PX[i][j].r = getc(fin);
			pic->PX[i][j].g = getc(fin);
			pic->PX[i][j].b = getc(fin);
		}
	}
	fclose(fin);						// close file
	return pic;
}
void PPMout(IMG *p1, char *outFile) 
{
	FILE *fout;							// open output file
	int i,j;

	fout = fopen(outFile,"w");			// write output file
	fprintf(fout, "%s\n", p1->header);	// print header
	fprintf(fout, "%d %d\n%d\n", p1->W, p1->H, p1->level);
		// print width, height, level
	for (j = 0; j < p1->H; j++) {		// print out color
		for (i = 0; i < p1->W; i++) {
			putc(p1->PX[i][j].r, fout);
			putc(p1->PX[i][j].g, fout); 
			putc(p1->PX[i][j].b, fout);
		}
	}
	fclose(fout);						// close file
	return;
}
IMG *PPMcvt(IMG *p1, IMG *ee, IMG *nthu) 
{	
	int i,j,k;
	int upperee = p1->H - ee->H;		// upper ee pixel
	int leftee = p1->W - ee->W;			// most left ee pixel
	IMG *pic;							// temp store outcome

	pic = malloc(sizeof(IMG));			// allocate space for outcome
	for(i = 0; i <= 3;i++)				// input header
		pic->header[i] = p1->header[i];
	pic->W = p1->W;						// input pic width
	pic->H = p1->H;						// input pic height
	pic->level = p1->level;				// input pic level
	pic->PX = (PIXEL **)malloc(p1->W * sizeof(int *));	// alloc pixel size
	for (i = 0; i < pic->W; i++)
		pic->PX[i] = (PIXEL *)malloc(p1->H * sizeof(PIXEL));
	for (j = 0; j < p1->H; j++) {		// change cloth color to green
		for (i = 0; i < p1->W; i++) {
			if ( p1->PX[i][j].g < 65 && // if red color change to green
			   ( p1->PX[i][j].r / ( p1->PX[i][j].b + 1 ) ) > 1.6 ) {
				pic->PX[i][j].r = p1->PX[i][j].g;
				pic->PX[i][j].g = p1->PX[i][j].r;
				pic->PX[i][j].b = p1->PX[i][j].b;
			}
			else {						// if not red color remain same
				pic->PX[i][j].r = p1->PX[i][j].r;
				pic->PX[i][j].g = p1->PX[i][j].g;
				pic->PX[i][j].b = p1->PX[i][j].b;
			}
		}
	}
	for (j = 0; j < nthu->H; j++) {		// print nthu logo upper left
		for (i = 0; i < nthu->W; i++) {
			if ( nthu->PX[i][j].r != 255 && nthu->PX[i][j].g != 255 &&
				 nthu->PX[i][j].b != 255) { // fliter out white and else purple
				pic->PX[i][j].r = 255;
				pic->PX[i][j].b = 255;
			}
		}
	}
	for (j = 0; j < ee->H; j++) {		// print ee logo buttom right
		for (i = 0; i < ee->W; i++) {
			if ( ee->PX[i][j].r != 255 && ee->PX[i][j].g != 255 &&
				 ee->PX[i][j].b != 255) {	// fliter out white
				pic->PX[leftee + i][upperee + j].r = ee->PX[i][j].r;
				pic->PX[leftee + i][upperee + j].g = ee->PX[i][j].g;
				pic->PX[leftee + i][upperee + j].b = ee->PX[i][j].b;
			}
		}
	}
	for (k = 0;k <= 10; k++) {
		for (j = 710; j < 880; j++) {	// print right edge of square
			pic->PX[950 + k][j].r = 255;	// all white edge
			pic->PX[950 + k][j].g = 255;
			pic->PX[950 + k][j].b = 255;		
		}
		for (j = 710; j < 880; j++) {	// print left edge of square
			pic->PX[1100 + k][j].r = 255;
			pic->PX[1100 + k][j].g = 255;
			pic->PX[1100 + k][j].b = 255;		
		}
		for (i = 950; i < 1110; i++) {	// print upper edge of square
			pic->PX[i][710 + k].r = 255;
			pic->PX[i][710 + k].g = 255;
			pic->PX[i][710 + k].b = 255;		
		}
		for (i = 950; i < 1110; i++) {	// print buttom edge of square
			pic->PX[i][880 + k].r = 255;
			pic->PX[i][880 + k].g = 255;
			pic->PX[i][880 + k].b = 255;		
		}	
	}

	return pic;
}
