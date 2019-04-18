#include <err.h>
#include <getopt.h>
#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

#define N 4096*4096

/* Get current time in micro-seconds */
int64_t timestamp(void) {
    struct timeval tv;
    if (gettimeofday(&tv, NULL) != 0)
        err(1, "gettimeofday");
    return tv.tv_sec * 1000000 + tv.tv_usec;
}

/* Initialize an N-element array. */
double *init_array(void) {
    int64_t t1, t2;

    t1 = timestamp();
    double *m = calloc(N, sizeof(double));
    if (m == NULL)
        err(1, "calloc");

    for (size_t i = 0; i < N; ++i)
        m[i] = (double) (i % 2);

    t2 = timestamp();
    printf("init_array: %" PRIi64 " micro-seconds\n", t2-t1);

    return m;
}

struct Node {
    double val;
    struct Node *next;
};

struct Node* init_list(void) {
    int64_t t1, t2;

    t1 = timestamp();

    struct Node *head = malloc(sizeof(struct Node));
    if (head == NULL)
        err(1, "malloc head");
    head->val = 0.0;


    struct Node *prev = head;
    for (int i = 1; i < N; ++i) {
        struct Node *curr = malloc(sizeof(struct Node));
        if (curr == NULL)
            err(1, "malloc curr");
        curr->val = (double) (i % 2);
        prev->next = curr;
        prev = curr;
    }
    prev->next = NULL;

    t2 = timestamp();
    printf("init_list: %" PRIi64 " micro-seconds\n", t2-t1);

    return head;
}


void sum_array(double *a) {
    int64_t t1, t2;

    t1 = timestamp();

    double s = 0.0;
    for (size_t i = 0; i < N; ++i)
        s += a[i];

    t2 = timestamp();
    printf("sum_array (%f): %" PRIi64 " micro-seconds\n", s, t2-t1);
}


void sum_list(struct Node *l) {
    int64_t t1, t2;

    t1 = timestamp();

    double s = 0.0;
    struct Node *curr = l;
    while (curr != NULL) {
        printf("%p\n", (void *)curr);
        s += curr->val;
        curr = curr->next;
    }

    t2 = timestamp();
    printf("sum_list (%f): %" PRIi64 " micro-seconds\n", s, t2-t1);
}


int main(int argc, char **argv) {
    int opt;
    double *a = init_array();
    struct Node *l = init_list();

    while ((opt = getopt(argc, argv, "la")) != -1) {
        switch (opt) {
        case 'a':
            sum_array(a);
            break;
        case 'l':
            sum_list(l);
            break;
        }
    }
    free(a);
    return 0;
}
