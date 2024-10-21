// exq2.c: operator overloading
//         complex number, operators: +, *

#include <iostream>
#include "exq20.h"

using std::cout;

int main(void)
{
    Complex a(2.0, 1.0);
    Complex b(1.0, 1.0);
    Complex c;
    double z = 2.0;

    cout << "a is ";
    a.printComplex();
    cout << "b is ";
    b.printComplex();

    c = a + b;
    cout << "c=a+b is ";
    c.printComplex();

    c = a * b;
    cout << "c=a*b is ";
    c.printComplex();

    c = a + z;
    cout << "c=a+2.0 is ";
    c.printComplex();

    c = a * z;
    cout << "c=a*2.0 is ";
    c.printComplex();
    return 0;
}
