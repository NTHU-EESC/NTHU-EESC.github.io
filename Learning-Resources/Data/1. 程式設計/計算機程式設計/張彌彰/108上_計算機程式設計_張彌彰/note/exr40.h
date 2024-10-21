// exr40.h: function overloading

#ifndef COMPLEX_H
#define COMPLEX_H

class Complex {
    public:
        Complex(double = 0, double = 0); // constructor
        void printComplex() const;       // print out real and imaginery
        double getReal() const;
        double getImag() const;
        double getMagnitude() const;
        double getPhase() const;
        Complex &incReal();
        Complex &incImag();
        Complex operator+(Complex &);    // complex addition
        Complex operator*(Complex &);    // complex multiplication
        Complex operator+(double &);     // add a scalar
        Complex operator*(double &);     // times a scalar
    private:
        double x, y;
};

#endif
