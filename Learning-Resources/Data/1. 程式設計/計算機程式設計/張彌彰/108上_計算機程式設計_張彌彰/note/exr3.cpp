// exr3.cpp: class template with nontype parameters
//         Bounded Array

#include <iostream>

using std::cin;
using std::cout;

template <class T, int n>
class BArray {                      // template for bound-checking array
    public:
        T& operator[](int);         // subscripting
    private:
        T val[n];
};

template <class T, int n>
T& BArray<T, n>::operator[](int i)   // subscripting operator
{
    int j = i;
    if (j < 0) j = 0;
    else if (j >= n) j = n - 1;
    return val[j];
}

template <class T,int n>
void BArrayReset(BArray<T, n> &ba)  // note: must use reference here
{
    int i;

    for (i = 0; i < n; i++) {
        ba[i] = 0;
    }
}

int main(void)
{
    BArray<int, 10> iArray;
    BArray<double, 5> dArray;
    BArray<char, 9> cArray;
    int i;

    for (i = 0; i < 10; i++) iArray[i] = i;
    for (i = 0; i < 5; i++) dArray[i] = 1.0 / (i + 1.0);
    for (i = 0; i < 9; i++) cArray[i] ='a' + i;

    for (i = -1; i <= 10; i++) {
        cout << "iArray[" << i << "] = " << iArray[i] << '\n';
    }
    for (i = -1; i <= 10; i++) {
        cout << "dArray[" << i << "] = " << dArray[i] << '\n';
    }
    for (i = -1; i <= 10; i++) {
        cout << "cArray[" << i << "] = " << cArray[i] << '\n';
    }

    BArrayReset(dArray);

    for (i = -1; i <= 10; i++) {
        cout << "dArray[" << i << "] = " << dArray[i] << '\n';
    }
    return 0;
}
