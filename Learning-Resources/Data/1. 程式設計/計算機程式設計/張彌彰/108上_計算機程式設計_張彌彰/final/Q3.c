// Q3 108061213 劉奕緯
// Given three strings, paragraph, phrase and new, it is known that the length
// of paragraph is longer than that of both phrase and new. Please write a
// function to generate a new string that is the paragraph with all
// occurrences of phrase replaced by new.
//
// For example,
// char paragraph[] = "Humpty Dumpty sat on a wall,
//             Humpty Dumpty had a great fall.
//             All the king's horses and all the king's men
//             Couldn't put Humpty Dumpty together again.";
// char phrase[] = "Humpty Dumpty"; and
// char new[] = "Hickory Dickory Dock";
//
// Calling replace function we get
// replace(paragraph, phrase, new) = "Hickory Dickory Dock sat on a wall,
//              Hickory Dickory Dock had a great fall.
//              All the king's horses and all the king's men
//              Couldn't put Hickory Dickory Dock together again."
#include <stdlib.h>
char *replace(char *paragraph, char *phrase, char *new)
{
	int para, ph;				// index for paragraph 
	int i, j, N = 0;			// i for index current phrase
	char *newp;					// new paragraph

	newp = malloc(sizeof(paragraph) * 2);
	para = ph = 0;				// if same record it.
	while (paragraph[para] != '\0') {
		if (paragraph[para] == phrase[i]) {
			i++;
			para++;
			if (phrase[i] == '\0')
				for (j = 0;new[j] != '\0';j++) {
					newp[N++] = new[j];
				}				// if all phrase are same replace it
				i = 0;
		}
		else {					// not equal than output all the same char before
			for (j = 0; j < i; j++)
				newp[N++] = phrase[j];
			newp[N++] = paragraph[para];
			i = 0;
			para++;
		}
	}
	newp[N] = '\0';
	return newp;
}
