// exr1.cpp: function template

#include <iostream>

using std::cin;
using std::cout;

template <typename T>
T SumArray(const T *Array, const int N)
{
    int i;
    T sum = 0;

    for (i = 0; i < N; i++) {
        sum += Array[i];
    }
    return sum;
}

int main(void)
{
    const int Ni = 6;
    const int Nd = 6;
    const int Nc = 4;
    int A[Ni] = {2, 3, 5, 7, 11, 13};
    double B[Nd] = {0.142857, 0.285714, 0.428571, 0.571429,
                     0.714286, 0.857143};
    char C[Nc] = {10, 13, 17, 40};

    cout << "Sum of Array A = " << SumArray(A,Ni) << '\n';
    cout << "Sum of Array B = " << SumArray(B,Nd) << '\n';
    cout << "Sum of Array C = " << SumArray(C,Nc) << '\n';
    return 0;
}

/* compiler generates 3 functions from the template
int SumArray(const int *Array, const int N)
{
    int i;
    int sum = 0;

    for (i = 0; i < N; i++) {
        sum += Array[i];
    }
    return sum;
}

double SumArray(const double *Array, const int N)
{
    int i;
    double sum = 0;

    for (i = 0; i < N; i++) {
        sum += Array[i];
    }
    return sum;
}

char SumArray(const char *Array, const int N)
{
    int i;
    char sum = 0;

    for (i = 0; i < N; i++) {
        sum += Array[i];
    }
    return sum;
}
*/
