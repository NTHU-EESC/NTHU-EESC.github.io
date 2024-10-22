#include <iostream>
#include <set>
#include <stdlib.h>
#include <time.h>
#include <string>
#include <vector>

int main() {

    FILE* t1 = fopen("Problem1_test_case.txt", "w");
    // FILE* t2 = fopen("Problem2_test_case.txt", "w");

    srand((unsigned) time(NULL));
    int numberOfVertices, numberOfEdges;
    numberOfVertices = 100;
    numberOfEdges = (numberOfVertices * (numberOfVertices - 1)) / 2;
    int seperate_t_and_b = rand() % 50 + 25;

    int pt1, pt2;

    // std::cout << numberOfVertices << ' ' << numberOfEdges << '\n';
    fprintf(t1, "%d %d\n", numberOfVertices, numberOfEdges);
    // fprintf(t2, "%d %d\n", numberOfVertices, numberOfEdges);

    int currNumE = 0;

    for (pt1 = 1; pt1 < numberOfVertices && currNumE < numberOfEdges; pt1++) {
        for (pt2 = pt1 + 1; pt2 <= numberOfVertices && currNumE < numberOfEdges; pt2++) {
            currNumE++;
            // std::cout << pt1 << ' ' << pt2 << ' ' << rand() % (100 - seperate_t_and_b) + seperate_t_and_b << ' ' << rand() % 100 + 1 << '\n';
            fprintf(t1, "%d %d %d %d\n", pt1, pt2, rand() % (100 - seperate_t_and_b) + seperate_t_and_b, rand() % 100 + 1);
            // fprintf(t2, "%d %d %d %d\n", pt1, pt2, rand() % (100 - seperate_t_and_b) + seperate_t_and_b, rand() % 100 + 1);
        }
    }

    // std::cout << '\n';
    fprintf(t1, "\n");
    // fprintf(t2, "\n");

    int fc = 100000;
    int id = 0;

    char ins[7] = "insert";
    char stp[5] = "stop";
    char rear[10] = "rearrange";

    char* opString[3] = {ins, stp, rear};

    std::set<int> stoppedId;

    int s, op, i, flag = 0;

    while (fc--) {
        op = ((rand() % 5) % 4) % 3;
        if (!flag) op = 0;
        if (op == 0) {
            flag = 1;
            s = rand() % numberOfVertices + 1;
            // std::cout << opString[op] << ' ' << ++id << ' ' << s << ' ' << "{ ";
            fprintf(t1, "%s %d %d { ", opString[op], ++id, s);
            // fprintf(t2, "%s %d %d { ", opString[op], id, s);
            for (i = 1; i <= numberOfVertices; i++) {
                fprintf(t1, "%d ", i);
                // if (i == s) fprintf(t2, "%d ", i);
                // else if (rand() % 3) fprintf(t2, "%d ", i);
            }

            fprintf(t1, "} %d\n", /*rand() % seperate_t_and_b + */1);
            // fprintf(t2, "} %d\n", rand() % seperate_t_and_b + 1);

            // std::cout << "} ";
            // std::cout << rand() % seperate_t_and_b + 1 << '\n';
        }
        else if (op == 1) {
            if (id == stoppedId.size()) {
                flag = 0;
                fc++;
                continue;
            }
            // std::cout << opString[op] << ' ';
            fprintf(t1, "%s ", opString[op]);
            // fprintf(t2, "%s ", opString[op]);
            while (true) {
                int stop_id = rand() % id + 1;
                if (stoppedId.find(stop_id) == stoppedId.end()) {
                    stoppedId.insert(stop_id);
                    // std::cout << stop_id << '\n';
                    fprintf(t1, "%d\n", stop_id);
                    // fprintf(t2, "%d\n", stop_id);
                    break;
                }
            }
        }
        else {
            if (id == 0) {
                flag = 0;
                fc++;
                continue;
            }
            // std::cout << opString[op] << '\n';
            fprintf(t1, "%s\n", opString[op]);
            // fprintf(t2, "%s\n", opString[op]);
        }
    }

    fclose(t1);
    // fclose(t2);

}

