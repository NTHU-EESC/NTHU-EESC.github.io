// EE231002 Lab14. Image Processing
// 109061158, 簡佳吟
// Date: 2021/1/4

#include <stdio.h>
#include <stdlib.h>

typedef struct sPIXEL {		// a single pixel
	unsigned char r, g, b;	// three color components

} PIXEL;

typedef struct sIMG {		// an image of PPM style
	char header[3];			// header, either P3 or P6
	int W, H;				// width and height of the image
	int level;				// intensity level of each color component
	PIXEL **PX;				// two-dimension array for all the pixels

} IMG;

IMG *PPMin(char *inFile);
	// This function opens the inFile, reads the image data 
	// and returns a pointer pointing to the newly created
	// image and data structure
void PPMout(IMG *pic, char *outFile);
	// This function writes the image pointed by p1 
	// to the output file outFile
	 
IMG *PPMcvt(IMG *pic, IMG *ee, IMG *nthu, int x1, int y1, int x2, int y2);
	// This function processes the image pointed by p1 
	// performing the modifications stated above and returns the new image 
	// as a result. The argument x1, y1 are the coordinates of the
	// lower-left corner of the box which retains the color image;
	// while x2, y2 are the coordinates of the corner of the box.
int main(int argc, char *argv[])
{
	IMG *pic, *ee, *nthu;		// image

	pic = PPMin(argv[1]);			// read its data
	ee = PPMin(argv[2]);
	nthu = PPMin(argv[3]);
	PPMout(PPMcvt(pic, ee, nthu, 3500, 2000,3700, 1800), argv[4]); // output
	return 0;	// done and return
}

// This function opens the inFile, reads the image data 
// and returns a pointer pointing to the newly created
// image and data structure
IMG *PPMin(char *inFile)
{
	int i, j;	// index for loop
	IMG *pic;		// the image 
	FILE *fin;		// the file
	
	pic = (IMG *)malloc(sizeof(IMG));	
	fin = fopen(inFile, "r");			// open file
	fscanf(fin, "%s", pic->header);		// scanf the image
	fscanf(fin, "%d %d\n%d\n", &pic->W, &pic->H, &pic->level);
	pic->PX = (PIXEL **)malloc(pic->W * sizeof(PIXEL *));

	for(i = 0; i < pic->W; i++) {
		pic->PX[i] = (PIXEL *)malloc(pic->H * sizeof(PIXEL)); 
	}
	for (j = 0; j < pic->H; j++) {			// scan the color component
		for (i = 0; i < pic->W; i++) {		// of each pixel
			pic->PX[i][j].r = getc(fin);
			pic->PX[i][j].g = getc(fin);
			pic->PX[i][j].b = getc(fin);
		}
	
	} 
	fclose(fin);	// close the file
	return pic;		// done and return
} 

// This function processes the image pointed by p1 
// performing the modifications stated above and returns the new image 
// as a result. The argument x1, y1 are the coordinates of the
// lower-left corner of the box which retains the color image;
// while x2, y2 are the coordinates of the corner of the box.
IMG *PPMcvt(IMG *p1, IMG *ee, IMG *nthu, int x1, int y1, int x2, int y2)
{
	int x, y, i, j;			// index for loop
	unsigned char gray;		// the color component of gray color
	PIXEL block = {0, 255, 255};	// cyan color block component
	
	// set the pic to black-white
	for (y = 0; y < p1->H; y++) {
		for (x = 0; x < p1->W; x++) {
			if (x < x1 || y < y2 || x > x2 || y > y1) { 
				gray = p1->PX[x][y].r * 0.2126;
				gray += p1->PX[x][y].g * 0.7152;
				gray += p1->PX[x][y].b * 0.0722;
				p1->PX[x][y].r = gray;
				p1->PX[x][y].g = gray;
				p1->PX[x][y].b = gray;
			}
		}
	}
	
	// add block on me
	// horizontal line 
	for (x = x1; x <= x2; x++) {
			p1->PX[x][y1] = block; 
			p1->PX[x][y2] = block;
	}
	// vertical line
	for (y = y2; y <= y1; y++) {
			p1->PX[x1][y] = block;
			p1->PX[x2][y] = block;
	}
	// paste EE logo
	for (y = 0, j = p1->H - ee->H - 200; y < ee->H && j < p1->H; y++, j++) {
		for (x = 0, i = (p1->W - ee->W) / 2 ; x < ee->W && i < p1->W ;
															x++, i++) {
			// ignore the white color
			if (ee->PX[x][y].r != 255 && ee->PX[x][y].g != 255 
										&& ee->PX[x][y].b != 255) {
										
				p1->PX[i][j] = ee->PX[x][y];
										
			}
		}
	} 
	// paste NTHU logo
	for (y = 0, j = 0; y < p1->H && j < nthu->H; y++, j++) {
		for (x = 0, i = 0; x < p1->W && i < nthu->W; x++, i++) {
			// ignore the white color
			if (nthu->PX[x][y].r != 255 && nthu->PX[x][y].g != 255 
											&& nthu->PX[x][y].b != 255) {
			
				p1->PX[x][y].g = nthu->PX[i][j].g;
				p1->PX[x][y].r = p1->PX[x][y].b = 255;
			}
		}
	}

	return p1;		// done and return
}

// This function writes the image pointed by p1 
// to the output file outFile
void PPMout(IMG *p1, char *outFile) 
{
	int i, j;		// index for loop
	FILE *fout;		// the outputfile 

	fout = fopen(outFile, "w");		// open the image
	fprintf(fout, "%s\n%d %d\n%d\n", p1->header, p1->W, p1->H, p1->level);
		// print the data
	for (j = 0; j < p1->H; j++) { 		// print the color component
		for (i = 0; i < p1->W; i++) {	// of each pixel
			fprintf(fout, "%c%c%c", p1->PX[i][j].r, p1->PX[i][j].g, 
													p1->PX[i][j].b);
		
		}
	}
	fclose(fout);			// close the file
}
