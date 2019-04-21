package main

import (
	"fmt"
	"os"
	"time"
)

const N int = 4096

func initMatrix() []float64 {
	t1 := time.Now()

	m := make([]float64, N*N)
	for i := 0; i < len(m); i++ {
		m[i] = float64(i % 2)
	}

	dur := time.Since(t1)
	fmt.Printf("initMatrix: %d micro-seconds\n", dur.Nanoseconds() / 1000)

	return m
}

func sumByRow(m []float64) {
	t1 := time.Now()

	s := 0.0;
	for row := 0; row < N; row++ {
		for col := 0; col < N; col++ {
			s += m[row*N + col]
		}
	}

	dur := time.Since(t1)
	fmt.Printf("sumByRow (%f): %d micro-seconds\n", s, dur.Nanoseconds() / 1000)
}

func sumByCol(m []float64) {
	t1 := time.Now()

	s := 0.0;
	for row := 0; row < N; row++ {
		for col := 0; col < N; col++ {
			s += m[row + col*N]
		}
	}

	dur := time.Since(t1)
	fmt.Printf("sumByCol (%f): %d micro-seconds\n", s, dur.Nanoseconds() / 1000)
}

func main() {
	m := initMatrix()

	for _, s := range os.Args[1:] {
		for _, c := range s {
			switch c {
			case 'r': sumByRow(m)
			case 'c': sumByCol(m)
			}
		}
	}
}
