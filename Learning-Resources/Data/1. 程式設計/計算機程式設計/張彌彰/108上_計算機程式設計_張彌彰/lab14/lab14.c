// EE231002 Lab14. Image Processing
// 108061213, 劉奕緯
// Dec. 28, 2019

#include <stdio.h>
#include <stdlib.h>

typedef struct sPIXEL {							// a pixel
	unsigned char r, g, b;						// three color components
} PIXEL;

typedef struct sIMG {							// an image of PPM style
	char header[5];								// header either P3 or P6
	int W, H;									// width and height of the image
	int level;									// intensity level of each color
	PIXEL **PX;									// 2-D array for all pixels
} IMG;

// This function opens the inFile, reads the image data and returns 
// a pointer pointing to the newly created image data structure.
IMG *PPMin(char *inFile);
// This function writes the image pointed by p1 to the output file outFile.
void PPMout(IMG *p1, char *outFile);
// convert p1 to black and while, paste ee and nthu log, and make a box
// where (x1, y1) is low-left coner and where (x2, y2) is upper-light coner
IMG *PPMcvt(IMG *p1, IMG *ee, IMG *nthu, int x1, int y1, int x2, int y2);

int main(int argc, char *argv[])
{
	IMG *photo, *EE, *TH;						// pointer to IMG, pic1, EE, 
												// NTHU, respectively

	photo = PPMin(argv[1]);						// input pic1,ppm
	EE = PPMin(argv[2]);						// input EE.ppm
	TH = PPMin(argv[3]);						// input NTHU.ppm
	PPMout(PPMcvt(photo, EE, TH, 1344, 1636, 1241, 1532), argv[4]);
												// convert and output to 
												// argv[4] file
	return 0;
}
// This function opens the inFile, reads the image data and returns 
// a pointer pointing to the newly created image data structure.
IMG *PPMin(char *inFile)
{
	int i, j;									// index
	FILE *fin;									// address of input file
	IMG *image = (IMG *)malloc(sizeof(IMG));	
												// pointer to this image
	
	fin = fopen(inFile, "r");					// open file
	fscanf(fin, "%s", image->header);			// start reading
	fscanf(fin, "%d%d", &image->W, &image->H);	 
	fscanf(fin, "%d\n", &image->level);
	// asking space for PIXELs
	image->PX = (PIXEL **)malloc(image->W * sizeof(PIXEL*));
	for (i = 0; i < image->W; i++)
		image->PX[i] = (PIXEL *)malloc(image->H * sizeof(PIXEL));
	// start reading PXIELs
	for (j = 0; j < image->H; j++) {
		for (i = 0; i < image->W; i++) {
			fscanf(fin, "%c", &image->PX[i][j].r);
			fscanf(fin, "%c", &image->PX[i][j].g);
			fscanf(fin, "%c", &image->PX[i][j].b);
		}
	}
	fclose(fin);
	return image;
}
// This function writes the image pointed by p1 to the output file outFile.
void PPMout(IMG *p1, char *outFile)
{
	FILE *fout; 								// address of output file
	int i, j;

	fout = fopen(outFile, "w");					// open file 
	fprintf(fout, "%s\n", p1->header);			// output in PPM format
	fprintf(fout, "%d %d\n", p1->W, p1->H);
	fprintf(fout, "%d\n", p1->level);
	for (j = 0; j < p1->H; j++) {
		for (i = 0; i < p1->W; i++) {
			fprintf(fout, "%c", p1->PX[i][j].r);
			fprintf(fout, "%c", p1->PX[i][j].g);
			fprintf(fout, "%c", p1->PX[i][j].b);
		}
	}
	fclose(fout);
}
// convert p1 to black and while, paste ee and nthu log, and make a box
// where (x1, y1) is low-left coner and where (x2, y2) is upper-light coner
IMG *PPMcvt(IMG *p1, IMG *ee, IMG *nthu, int x1, int y1, int x2, int y2)
{
	int x, y, i, j;								// index
	PIXEL cyan = {0, 255, 255};					// a cyan PIXEL
	
	// convert to black-white image
	for (x = 0; x < p1->W; x++) 
		for (y = 0; y < p1->H; y++) 
			if (x < x2 || y < y2 || x > x1 || y > y1) {
				p1->PX[x][y].b = p1->PX[x][y].g = p1->PX[x][y].r 
					= p1->PX[x][y].r * 0.2126 + p1->PX[x][y].g * 0.7152 
					+ p1->PX[x][y].b * 0.0722;
			}
	// put a cyan box around my head
	// vertical lines
	for (x = x2; x < x1; x++) {
		for (j = 0; j < 3; j++) {				// line width is 3px
			p1->PX[x][y2 + j] = cyan;
			p1->PX[x][y1 - j] = cyan;
		}
	}
	// horizontal lines
	for (y = y2; y < y1; y++) {
		for (j = 0; j < 3; j++) {				// line width is 3px
			p1->PX[x2 + j][y] = cyan;
			p1->PX[x1 - j][y] = cyan;
		}
	}
	// paste EE logo
	for (x = 0, i = p1->W - ee->W; x < ee->W; x++, i++) 
		for (y = 0, j = p1->H -ee->H; y < ee->H; y++, j++) 
			// remove white PIXEL
			if (ee->PX[x][y].r != 255 && ee->PX[x][y].g != 255 
										&& ee->PX[x][y].b != 255) 
				p1->PX[i][j] = ee->PX[x][y];
	// paste NTHU logo
	for (x = 0, i = (p1->W - nthu->W) / 2; x < nthu->W; x++, i++) 
		for (y = 0, j = (p1->H - nthu->H) / 2 ; y < nthu->H; y++, j++) 
			// ignore white PIXEL
			if (nthu->PX[x][y].r != 255 && nthu->PX[x][y].g != 255 
										&& nthu->PX[x][y].b != 255) {
				p1->PX[i][j].g = nthu->PX[x][y].g;
				p1->PX[i][j].r = p1->PX[i][j].b = 255;
												// turn b, r, to max
			}
	return p1;
}
