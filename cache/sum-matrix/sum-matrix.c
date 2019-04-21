#include <err.h>
#include <getopt.h>
#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

#define N 4096

/* Get current time in micro-seconds */
int64_t timestamp(void) {
    struct timeval tv;
    if (gettimeofday(&tv, NULL) != 0)
        err(1, "gettimeofday");
    return tv.tv_sec * 1000000 + tv.tv_usec;
}

/* Initialize an NxN matrix. */
double *init_matrix(void) {
    int64_t t1, t2;

    t1 = timestamp();
    double *m = calloc(N*N, sizeof(double));
    if (m == NULL)
        err(1, "calloc");

    for (size_t i = 0; i < N*N; ++i)
        m[i] = (double) (i % 2);

    t2 = timestamp();
    printf("init_matrix: %" PRIi64 " micro-seconds\n", t2-t1);

    return m;
}

void sum_by_row(double *m) {
    double sum = 0.0;
    int64_t t1, t2;

    t1 = timestamp();
    for (size_t row = 0; row < N; ++row) {
        for (size_t col = 0; col < N; ++col) {
            sum += *(m + (row * N) + col);
        }
    }
    t2 = timestamp();
    printf("sum_by_row (%f): %" PRIi64 " micro-seconds\n", sum, t2-t1);
}

void sum_by_col(double *m) {
    double sum = 0.0;
    int64_t t1, t2;

    t1 = timestamp();
    for (size_t row = 0; row < N; ++row) {
        for (size_t col = 0; col < N; ++col) {
            sum += *(m + row + (col * N));
        }
    }
    t2 = timestamp();
    printf("sum_by_col (%f): %" PRIi64 " micro-seconds\n", sum, t2-t1);
}

int main(int argc, char **argv) {
    int opt;
    double *m = init_matrix();

    while ((opt = getopt(argc, argv, "rc")) != -1) {
        switch (opt) {
        case 'r':
            sum_by_row(m);
            break;
        case 'c':
            sum_by_col(m);
            break;
        }
    }
    free(m);
    return 0;
}
