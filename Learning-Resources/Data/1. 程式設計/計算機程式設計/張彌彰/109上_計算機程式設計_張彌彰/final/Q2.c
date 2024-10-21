// Q2 109061158 簡佳吟
// Given a string str, please write a function to
// return a NEW string which is a copy of str.
//
// For example, if str points to "this is a good day."
//   then the function returns a pointer pointing to the memory location
//   that contains the NEW string "this is a good day."
//

char *STRcopy(char *str)
{
	int i; 				// index for loop		
	char *newstr;		// new pointer to new string
	int len;
	
	for (len = 0; str[len] != '\0'; len++) ;		// the length of old string 
	len++;											// set a space for '/0'
	newstr = (char *)malloc(sizeof(str) * len);		// give memory as same as 
													// the old one
	for (i = 0; str[i] != '\0'; i++) {
		newstr[i] = str[i];							// initialize
	}
	newstr[i] = '\0';

	return newstr;									// done and return
}

