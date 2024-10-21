// exq3.c: operator overloading
//         complex number, operators: +, *

#include <iostream>
#include "exq30.h"

using std::cout;

int main(void)
{
    Complex a(2.0, 1.0);
    Complex b(1.0, 1.0);
    double x = 5.9, y = 3.14;

    cout << "a=" << a << '\n';
    cout << "b=" << b << '\n';

    cout << "a+b=" << a + b << '\n';
    cout << "x=" << x << " y=" << y << '\n';
    cout << "a+x=" << a + x << '\n';
    cout << "x+b+y=" << x + b + y << '\n';

    cout << "a*b=" << a * b << '\n';
    cout << "2.0*a*a=" << 2.0 * a * a << '\n';
    cout << "3*a=" << 3.0 * a << '\n';
    cout << "2.0*a*a+3.0*a+4.0=" << 2.0 * a * a + 3.0 * a + 4.0 << '\n';

    Complex c;
    cout << "a= " << a << '\n';
    c = ++a;
    cout << "c= ++a; c=" << c << " a=" << a << '\n';
    c = a++;
    cout << "c= a++; c=" << c << " a=" << a << '\n';

    for (int i = 1; i < 4; i++) {
        c = a^i;
        cout << "a^" << i << "= " << c << '\n';
    }

    // type conversion
    cout << "a=" << a << '\n';
    cout << "x=" << x << '\n';
    x = a;
    cout << "after x=a, x=" << x << '\n';

    // use type conversion to minimize number of
    //   overloaded functions
    a = Complex(1.0, 1.0);
    b = Complex(2.0, 1.0);
    cout << "a=" << a << '\n';
    cout << "b=" << b << '\n';

//  the following codes have compilation errors due to
//  operator-(double, Complex) not defined

//  cout << "a-b=" << a - b << '\n';
//  cout << "x=" << x << " y =" << y << '\n';
//  cout << "a-x=" << a - x << '\n';
//  cout << "x-b-y=" << x - b - y << '\n';
}
