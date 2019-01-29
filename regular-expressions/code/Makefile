CC=gcc
CFLAGS=-Wall -O2 -std=gnu99

all: remi remi2

remi: remi.c
	$(CC) $(CFLAGS) -o $@ $^

remi2: remi2.c
	$(CC) $(CFLAGS) -o $@ $^

clean:
	rm -f remi remi2

.PHONY: all clean
