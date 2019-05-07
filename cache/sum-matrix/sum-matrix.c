#include <err.h>
#include <getopt.h>
#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

static size_t ROWS = 1<<12;
static size_t COLS = 1<<12;

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
    fprintf(stderr, "allocating %" PRIu64 " x %" PRIu64 " matrix\n", ROWS, COLS);
    double *m = calloc(ROWS*COLS, sizeof(double));
    if (m == NULL)
        err(1, "calloc");

    for (size_t i = 0; i < ROWS*COLS; ++i)
        m[i] = (double) (i % 2);

    t2 = timestamp();
    printf("init_matrix: %" PRIi64 " micro-seconds\n", t2-t1);

    return m;
}

void sum_by_row(double *m) {
    double sum = 0.0;
    int64_t t1, t2;

    t1 = timestamp();
    for (size_t row = 0; row < ROWS; ++row) {
        for (size_t col = 0; col < COLS; ++col) {
            sum += m[(row * COLS) + col];
        }
    }
    t2 = timestamp();
    printf("sum_by_row (%f): %" PRIi64 " micro-seconds\n", sum, t2-t1);
}

void sum_by_col(double *m) {
    double sum = 0.0;
    int64_t t1, t2;

    t1 = timestamp();
    for (size_t row = 0; row < ROWS; ++row) {
        for (size_t col = 0; col < COLS; ++col) {
            sum += m[row + (col * ROWS)];
        }
    }
    t2 = timestamp();
    printf("sum_by_col (%f): %" PRIi64 " micro-seconds\n", sum, t2-t1);
}

int main(int argc, char **argv) {
    int opt;

    while ((opt = getopt(argc, argv, "r:c:")) != -1) {
        switch (opt) {
        case 'r':
            ROWS = 1 << atoi(optarg);
            break;
        case 'c':
            COLS = 1 << atoi(optarg);
            break;
        }
    }

    fprintf(stderr, "ROWS=%" PRIu64 " COLS=%" PRIu64 "\n", ROWS, COLS);
    double *m = init_matrix();

    for (int i = optind; i < argc; ++i) {
        char *arg = argv[i];
        while (*arg != 0) {
            switch (*arg) {
            case 'c':
                sum_by_col(m);
                break;
            case 'r':
                sum_by_row(m);
                break;
            }
            arg++;
        }
    }

    free(m);
    return 0;
}
