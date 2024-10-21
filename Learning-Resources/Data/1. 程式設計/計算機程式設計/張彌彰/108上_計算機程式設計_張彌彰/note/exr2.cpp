// exr2.cpp: class template
//         Bounded Array example

#include <iostream>

using std::cin;
using std::cout;

template <class T>
class BArray {                    // template for bound-checking array
    public:
        BArray(int n);            // initialize to have n elements
        ~BArray() { delete [] val; }      // destructor
        T& operator[](int);               // subscripting
    private:
        T *val;
        int size;
};

template< class T>
BArray<T>::BArray(int n)               // constructor
{
    size = n;
    val = new T[n];                    // allocate array
}
/*  alternative destructor defintion
template< class T>
BArray<T>::~BArray()                   // destructor
{
    delete [] val;                     // release array
}
*/
template< class T>
T& BArray<T>::operator[](int n)        // subscripting operator
{
    int i = n;
    if (i < 0) i = 0;
    else if (i >= size) i = size - 1;
    return val[i];
}

template< class T>
void BArrayReset(BArray<T> &ba)        // note: must use reference here
{
    int i;

    for (i= -5; i < 20; i++) {
        ba[i] = 0;
    }
}

int main(void)
{
    BArray<int>    iArray(10);
    BArray<double> dArray(5);
    BArray<char>   cArray(9);
    int i;

    for (i = 0; i < 10; i++) iArray[i] = i;
    for (i = 0; i < 5; i++) dArray[i ]= 1.0 / (i + 1.0);
    for (i = 0; i < 9; i++) cArray[i] = 'a' + i;

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
