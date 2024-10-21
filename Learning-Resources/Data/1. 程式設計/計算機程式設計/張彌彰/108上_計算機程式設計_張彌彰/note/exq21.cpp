// exq21.cpp: function overloading

#include <iostream>
#include <cmath>
#include "exq20.h"

using std::cin;
using std::cout;

Complex::Complex(double r, double i)
// : x(r), y(i)        // using initializer
{
    x = r;
    y = i;
}

void Complex::printComplex() const
{
    cout << " (" << x << ", " << y << ")\n";
}

double Complex::getReal() const
{
    return x;
}

double Complex::getImag() const
{
    return y;
}

double Complex::getMagnitude() const
{
    double z;

    z = sqrt(x * x + y * y);
    return z;
}

double Complex::getPhase() const
{
    double z;

    if (x == 0) return 1.570814;
    z = atan(y / x);
    return z;
}

Complex &Complex::incReal()
{
    x = x + 1.0;
    return (*this);
}

Complex &Complex::incImag()
{
    y = y + 1.0;
    return (*this);
}

Complex Complex::operator+(Complex &b)
{
    Complex s;

    s.x = x + b.x;
    s.y = y + b.y;
    return s;
}

Complex Complex::operator*(Complex &b)
{
    Complex s;

    s.x = (x * b.x) - (y * b.y);
    s.y = (x * b.y) + (y * b.x);
    return s;
}

Complex Complex::operator+(double &b)
{
    Complex s;

    s.x = x + b;
    s.y = y;
    return s;
}

Complex Complex::operator*(double &b)
{
    Complex s;

    s.x = x * b;
    s.y = y * b;
    return s;
}
