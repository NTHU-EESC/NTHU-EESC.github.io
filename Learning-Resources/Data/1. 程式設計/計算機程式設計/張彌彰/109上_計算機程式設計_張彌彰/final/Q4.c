// Q4 109061158 簡佳吟
// A group of N students are participating in a academic competition.
// Three tests were taken by each students: mathematics, science and
// literature. The scores of these students have been organized into
// an array of structures, together with their names. Given that array
// please write a function to find the average of the science scores
// of the students.

#define N 100
struct STU {                // structure definition for each students
    char fName[15];         // first name
    char lName[15];         // last name
    double math, sci, lit;  // test scores
};

struct STU list[N];       // all students' results as an array of struct

double aveScience(struct STU list[N])
{
	int i;				// index for loop
	double avg;			// average of science score
	double sum = 0;		// sum of science score

	for (i = 0; i < N; i++) {
		sum += list[i].sci;		// sum all science score
	}
	avg = sum / N;				// calculate the average
	
	return avg;					// done and return
}


