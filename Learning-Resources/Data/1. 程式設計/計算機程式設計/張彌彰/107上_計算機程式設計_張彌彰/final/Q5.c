// Q5 u107061113 李柏葳
// Given an even integer N, it has been conjectured that N can always be
// expressed as the sum of two prime numbers. Please write a C function
// that given an even integer N, it prints out all possible two prime
// numbers with the sum equals to N, or prints out "No pair available"
// if no such pair of prime numbers exists.
//
// For example, calling SumOfPrime(28) prints out
// Set 1: 5 23
// Set 2: 11 17
// 2 pairs found.

void SumOfPrime(int N)
{
	int i,j;
	int pairs = 0;
	int isprime = 1;
	int prime1, prime2;
	for (i = 2; i <= (N / 2); i++) {
		isprime = 1;
		prime1 = i;
		prime2 = (N - i);
		for (j = 2; (j < prime1) && isprime; j++) {
			if (prime1 % j == 0)
				isprime--;
		}
		for (j = 2; (j < prime2) && isprime; j++) {
			if (prime2 % j == 0)
				isprime--;
		}
		if (isprime) {
			pairs++;
			printf("Set %d: %d %d", pairs, prime1, prime2);
		}
	}
	if (pairs)
		printf("No pair available.");
	else printf("%d pairs found.", pairs);

	return;
}
