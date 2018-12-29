#include <err.h>
#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/time.h>

#define CACHE_LINES 64

const char *PROG_NAME;

void usage(void) {
    fprintf(stderr,
            "usage: %s <array-fast | array-fast-i32 | array-slow | linked-list> <size>\n",
            PROG_NAME);
    exit(1);
}


/* Get current time in micro-seconds */
int64_t timestamp(void) {
    struct timeval tv;
    if (gettimeofday(&tv, NULL) != 0)
        errx(1, "gettimeofday");
    return tv.tv_sec * 1000000 + tv.tv_usec;
}

/* Caller responsible for calling `free()`. */
int64_t* array_init(size_t size) {
    int64_t t1 = timestamp();
    int64_t *elems;

    /* Initialize an array [1, 2, 1, 2, 1, 2, ...] of length `size`. */
    {
        elems = malloc(sizeof(*elems) * size);
        if (elems == NULL)
            errx(1, "malloc");


        for (size_t i = 0; i < size; ++i) {
            elems[i] = 1 + (i % 2);
        }
    }

    int64_t t2 = timestamp();
    fprintf(stderr, "initialization: %" PRId64 " us\n", t2-t1);
    return elems;
}

void array_fast(size_t size) {
    int64_t *elems = array_init(size);

    /* Compute sum element-by-element sequentially. */
    {
        int64_t t1 = timestamp();
        int64_t sum = 0;
        for (size_t i = 0; i < size; ++i)
            sum += elems[i];
        int64_t t2 = timestamp();
        fprintf(stderr, "sum (%" PRId64 "): %" PRId64 " us\n", sum, t2-t1);
    }
}

void array_fast_i32(size_t size) {
    int32_t *elems;
    {
        int64_t t1 = timestamp();
        elems = malloc(sizeof(*elems) * size);
        if (elems == NULL)
            errx(1, "malloc");


        for (size_t i = 0; i < size; ++i) {
            elems[i] = 1 + (i % 2);
        }

        int64_t t2 = timestamp();
        fprintf(stderr, "initialization: %" PRId64 " us\n", t2-t1);
    }

    {
        int64_t t1 = timestamp();
        int32_t sum = 0;
        for (size_t i = 0; i < size; ++i)
            sum += elems[i];
        int64_t t2 = timestamp();
        fprintf(stderr, "sum (%" PRId32 "): %" PRId64 " us\n", sum, t2-t1);
    }
}

void array_slow(size_t size) {
    int64_t *elems = array_init(size);

    /* Compute sum element-by-element, but with cache-line-sized gaps
     * between array accesses. */
    {
        int64_t t1 = timestamp();
        int64_t sum = 0;

        for (size_t j = 0; j < CACHE_LINES; ++j)
            for (size_t i = j; i < size; i += CACHE_LINES)
                sum += elems[i];

        int64_t t2 = timestamp();
        fprintf(stderr, "sum (%" PRId64 "): %" PRId64 " us\n", sum, t2-t1);
    }
}

struct ListNode {
    int64_t value;
    struct ListNode *prev;
};

void linked_list(size_t size) {
    struct ListNode *list_head = NULL;

    /* Initialize linked list. */
    {
        int64_t t1 = timestamp();

        for (size_t i = 0; i < size; ++i) {
            struct ListNode *new_node = malloc(sizeof(*list_head));
            if (new_node == NULL)
                errx(1, "malloc");
            new_node->value = 1 + (i % 2);
            new_node->prev = list_head;
            list_head = new_node;
        }

        int64_t t2 = timestamp();
        fprintf(stderr, "initialization: %" PRId64 " us\n", t2-t1);
    }

    /* Sum the linked list. */
    {
        int64_t t1 = timestamp();
        int64_t sum = 0;

        while (list_head != NULL) {
            sum += list_head->value;
            list_head = list_head->prev;
        }

        int64_t t2 = timestamp();
        fprintf(stderr, "sum (%" PRId64 "): %" PRId64 " us\n", sum, t2-t1);
    }

    /* Let the OS take care of freeing the list. */
}

int main(int argc, char **argv) {
    PROG_NAME = argv[0];
    if (argc < 3)
        usage();

    size_t size = atoll(argv[2]);

    if (strcmp(argv[1], "array-fast") == 0)
        array_fast(size);
    else if (strcmp(argv[1], "array-fast-i32") == 0)
        array_fast_i32(size);
    else if (strcmp(argv[1], "array-slow") == 0)
        array_slow(size);
    else if (strcmp(argv[1], "array-unrolled") == 0)
        array_slow(size);
    else if (strcmp(argv[1], "linked-list") == 0)
        linked_list(size);
    else
        usage();

    return 0;
}
