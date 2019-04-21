OUTPUT_PROGRAMS = SumMatrix.class sum-matrix-c sum-matrix-rs sum-matrix-go

all: ${OUTPUT_PROGRAMS}

clean:
	rm -f ${OUTPUT_PROGRAMS}

SumMatrix.class: SumMatrix.java
	javac $<

sum-matrix-c: sum-matrix.c
	gcc -O2 -g -Wall -Wextra -pedantic -std=c99 -o $@ $<

sum-matrix-rs: sum-matrix.rs
	rustc -O -o $@ $<

sum-matrix-go: sum-matrix.go
	go build -o $@ $<


.PHONY: all clean
