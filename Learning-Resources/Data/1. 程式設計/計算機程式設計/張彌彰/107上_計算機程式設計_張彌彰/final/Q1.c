// Q1 u107061113 李柏葳
// Given a string, S, that contains many sentences. The function Cap(S)
// modifies the string such that that first non-space letter of a sentence
// is capitalized. For example,
//
// S = "today is Monday. everyone works on Monday.  tomorrow is Tuesday."
//
// After calling Cap(S), we have S modified to be
//
// S = "Today is Monday. Everyone works on Monday.  Tomorrow is Tuesday."
//

void Cap(char *S)
{
	int i,j;
	
	if (S[0] >= 97 && S[0] <= 122)
		S[0] -= ('a' - 'A');
	for (i = 1; S[i] != '\0'; i++) {
		if (S[i] == '.' && S[i + 1] != '\0') {
			for (j = i + 1; S[j] == ' '; j++) {};
				if (S[j] >= 97 && S[j] <= 122)
					S[j] -= ('a' - 'A');
		}
	}

	return;
}

