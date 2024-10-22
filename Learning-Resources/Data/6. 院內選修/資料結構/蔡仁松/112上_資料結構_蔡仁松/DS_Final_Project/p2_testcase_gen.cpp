#include <iostream>

int main() {
    FILE* out = fopen("Problem2_test_case.txt", "w");
    fprintf(out, "%d %d\n", 3, 2);
    fprintf(out, "%d %d %d %d\n", 1, 2, 10, 5);
    fprintf(out, "%d %d %d %d\n", 2, 3, 10, 2);
    fprintf(out, "\n");
    int opt = 100000;
    for (int i = 1; i <= 100000; i++) {
        fprintf(out, "insert %d 1 { 1 2 3 } 10\n", i);
    }
    fclose(out);
}