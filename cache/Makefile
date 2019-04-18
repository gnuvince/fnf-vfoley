CC ?= gcc
CFLAGS ?= -O2 -g -Wall -Wextra -pedantic -std=c99

all: sum-matrix array-vs-list

clean:
	rm -f sum-matrix array-vs-list

sum-matrix: sum-matrix.c
	$(CC) $(CFLAGS) -o $@ $<

array-vs-list: array-vs-list.c
	$(CC) $(CFLAGS) -o $@ $<

.PHONY: all clean
