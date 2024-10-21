// exq31.cpp: complex number with shorthand operators

#include <iostream>
#include "exq30.h"
using namespace std;

using std::cin;
using std::cout;

double Complex::real() const
{
    return x;
}

double Complex::imag() const
{
    return y;
}

Complex& Complex::operator+=(Complex a)
{
    x += a.real();
    y += a.imag();
    return (*this);
}

Complex& Complex::operator+=(double dbl)
{
    x += dbl;
    return (*this);
}

Complex operator+(Complex a, Complex b)
{
    double x,y;
    x = a.real() + b.real();
    y = a.imag() + b.imag();
    return Complex(x, y);
}

Complex operator+(Complex a, double dbl)
{
    double x,y;
    x = a.real() + dbl;
    y = a.imag();
    return Complex(x, y);
}

Complex operator+(double dbl, Complex a)
{
    double x, y;
    x = a.real() + dbl;
    y = a.imag();
    return Complex(x, y);
}

Complex& Complex::operator-=(Complex a)
{
    x -= a.real();
    y -= a.imag();
    return (*this);
}

Complex& Complex::operator*=(Complex a)
{
    double r, i;
    r = x * a.real() - y * a.imag();
    i = x * a.imag() + y * a.real();
    x = r;
    y = i;
    return (*this);
}

Complex& Complex::operator*=(double dbl)
{
    x *= dbl;
    y *= dbl;
    return (*this);
}

Complex operator*(Complex a, Complex b)
{
    double x, y;
    x = a.real() * b.real() - a.imag() * b.imag();
    y = a.real() * b.imag() + a.imag() * b.real();
    return Complex(x, y);
}

Complex operator*(Complex a, double dbl)
{
    double x, y;
    x = a.real() * dbl;
    y = a.imag() * dbl;
    return Complex(x, y);
}

Complex operator*(double dbl, Complex a)
{
    double x, y;
    x = a.real() * dbl;
    y = a.imag() * dbl;
    return Complex(x, y);
}

Complex operator+(Complex a)        // unary +
{
    return Complex(a.real(), a.imag());
}

Complex& operator++(Complex &a)    // prefix increment
{
    a += Complex(1.0, 0);
    return a;
}

Complex operator++(Complex &a, int i)    // postfix increment
{
    Complex b = a;
    a += Complex(1.0, 0);
    return b;
}

Complex operator^(Complex a, int n)        // a^n, power function
{
    Complex b = a;
    int j;

    if (n <= 0) {
        b = Complex(1.0, 0);
        return b;
    }
    else {
        for (j = 1; j < n; j++) {
            b *= a;
        }
        return b;
    }
}

Complex operator-(Complex a, Complex b)
{
    double x, y;
    x = a.real() - b.real();
    y = a.imag() - b.imag();
    return Complex(x, y);
}

bool operator==(Complex a, Complex b)
{
    return ((a.real() == b.real()) && (a.imag() == b.imag()));
}

bool operator!=(Complex a, Complex b)
{
    return !((a.real() == b.real()) && (a.imag() == b.imag()));
}

ostream& operator<<(ostream& s, Complex const z)
{
    return s << '(' << z.real() << ',' << z.imag() << ')' ;
}

istream& operator>>(istream& s, Complex& z)
{
    double r = 0, i = 0;
    char c = 0;

    s >> c;
    if (c == '(') {
        s >> r >> c;
        if (c == ',') s >> i >> c;
        if (c != ')') s.clear(ios_base::badbit);
				// house keeping: set state
    }
    else {
        s.putback(c);
        s >> r;
    }
    if (s) z = Complex(r, i);
    return(s);
}

Complex::operator double()
{
    return x;
}
