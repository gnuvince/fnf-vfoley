use rand::prelude::*;
use std::time::Instant;
use std::env::args;

type Element = i64;
const N: Element = 1<<15;

fn check_sorted(xs: &[Element]) {
    for (a, b) in xs.iter().zip(xs[1..].iter()) {
        assert!(a <= b);
    }
}

fn bubble_sort(xs: &mut [Element]) {
    for i in 0 .. xs.len() {
        for j in i+1 .. xs.len() {
            if xs[i] > xs[j] {
                xs.swap(i, j);
            }
        }
    }
}

fn selection_sort(xs: &mut [Element]) {
    for i in 0 .. xs.len() {
        for j in i+1 .. xs.len() {
            if xs[j] < xs[i] {
                xs.swap(i, j);
            }
        }
    }
}

fn run_sort(name: &str, sort_fn: fn(&mut [Element]), v: &mut [Element]) {
    let top = Instant::now();
    sort_fn(v);
    let sort_time = top.elapsed();
    check_sorted(&v);
    println!("{} {}.{:06}", name, sort_time.as_secs(), sort_time.subsec_micros());

}

fn main() {
    let mut v: Vec<Element> = (0 .. N).collect();
    let mut rng = rand::thread_rng();
    for arg in args().skip(1) {
        for b in arg.bytes() {
            v.shuffle(&mut rng);
            match b {
                b'b' => run_sort("bubble_sort", bubble_sort, &mut v),
                b's' => run_sort("selection_sort", selection_sort, &mut v),
                _ => ()
            }
        }
    }
}
