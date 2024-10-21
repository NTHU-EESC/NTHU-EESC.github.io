// exq5.cpp: constructor/destructor

#include <iostream>
using namespace std;

class Complex {                        // complex number class
    public:
        Complex() {};                  // uninit constructor
        Complex(double,double);        // initialization constructor
        Complex(Complex &);            // copy constructor
        Complex  operator+(Complex);   // C1 + C2
        Complex &operator+=(Complex&); // C1 += C2;
        void print();                  // print to output
    private:
        double x, y;
};

Complex::Complex(double r, double i = 0)  // init constructor
{
    x = r; y = i;
}

Complex::Complex(Complex &a)           // copy constructor
{
    x = a.x; y = a.y;
}

Complex Complex::operator+(Complex a)  // Complex + Complex
{
    Complex z(x + a.x, y + a.y);
    return z;
}

Complex &Complex::operator+=(Complex &a) // compound assignment
{
    x += a.x;
    y += a.y;
    return (*this);
}

void Complex::print()                    // print complex number
{
    cout << "(" << x << "," << y << ")";
}

int main(void)
{
    Complex One(1, 0);                  // init constructor
    Complex z1(3, 0);                   // init constructor
    Complex z2(0);                      // init constructor
    Complex z3 = One;                   // copy constructor

    {
        Complex z2;                     // uninit constructor
        z2 = z1 + One;                  // complex add
        z2.print(); cout << endl;       // complex print
    }
    z2 += One;                          // compound assignment
    z2.print(); cout << endl;           // complex print
    return 0;
}
