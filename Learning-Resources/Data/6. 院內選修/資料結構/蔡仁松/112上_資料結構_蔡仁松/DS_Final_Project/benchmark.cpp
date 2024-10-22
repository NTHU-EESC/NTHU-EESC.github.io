#include <sys/times.h>
#include <unistd.h>
#include <cstdio>



int main(void) {
    struct tms  tmsstart, tmsend;
    clock_t     start, end;
    static long     clktck = 0;
    clktck = sysconf(_SC_CLK_TCK);
    start = times(&tmsstart);
    int target = 50000000;
    int dev;

    for (int i = 2; i < target; i++) {
        for (dev = 2; dev * dev < target; dev++) {
            if (i % dev == 0) break;
        }
    }

    end = times(&tmsend);

    printf(" real:  %7.7f\n", (end-start) / (double) clktck);
    printf(" user:  %7.7f\n",
            (tmsend.tms_utime - tmsstart.tms_utime) / (double) clktck);
    printf(" sys:   %7.7f\n",
            (tmsend.tms_stime - tmsstart.tms_stime) / (double) clktck);
    return 0;
}

