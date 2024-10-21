// exq4.cpp: associative array with [] subscripting

#include <iostream>
#include <cstring>
using std::cout;

class ZipCode {
    public:
        int operator[](char *) const;
        void addZip(int,char *,int);     // add (city, zip) to i'th element
    private:
        char city[5][10];
        int  zip[5];
};

int ZipCode::operator[](char *s) const
{
    int i;
    for (i = 0; i < 5; i++) {
        if (strcmp(city[i], s) == 0) {
            return zip[i];
        }
    }
    return 0;
}

void ZipCode::addZip(int index, char *name, int code)
{
    strcpy(city[index], name);
    zip[index] = code;
}

int main(void)
{
    ZipCode tw;        // new ZipCode object
    int i;

    // add city and zip code
    char c1[10] = "台北";    tw.addZip(0, c1, 100);
    char c2[10] = "桃園";    tw.addZip(1, c2, 200);
    char c3[10] = "新竹";    tw.addZip(2, c3, 300);
    char c4[10] = "台中";    tw.addZip(3, c4, 400);
    char c5[10] = "台南";    tw.addZip(4, c5, 500);

    char c[10] = "新竹";
    i = tw[c];
    cout << "新竹 zip code is " << i << '\n';
    i = tw[(char *)"桃園"];
    cout << "桃園 zip code is " << i << '\n';
    return 0;
}
