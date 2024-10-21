// exq30.h: function overloading

#ifndef COMPLEX_H
#define COMPLEX_H

#include <iostream>
using std::ostream;
using std::istream;

class Complex {
    public:
        Complex(double r=0,double i=0): x(r), y(i) {} // constructor
        double real() const;                       // get real part
        double imag() const;                       // get imaginary part
        Complex& operator+=(Complex);              // C1 += C2;
        Complex& operator+=(double);               // C1 += dbl;
        Complex& operator*=(Complex);              // C1 *= C2;
        Complex& operator*=(double);               // C1 *= dbl;
        Complex& operator-=(Complex);              // C1 -= C2;
        operator double();                         // type conversion
    private:
        double x, y;
};

Complex operator+(Complex, Complex);
Complex operator+(Complex, double);
Complex operator+(double, Complex);
Complex operator*(Complex, Complex);
Complex operator*(Complex, double);
Complex operator*(double, Complex);
Complex operator+(Complex);                // unary plus
Complex &operator++(Complex&);             // prefix increment
Complex operator++(Complex&, int);         // postfix increment
Complex operator^(Complex, int);           // int power function
Complex operator-(Complex, Complex);
bool operator==(Complex, Complex);
bool operator!=(Complex, Complex);

istream &operator>>(istream &, Complex&);         // input
ostream &operator<<(ostream &, Complex const);    // output

#endif
