use std::time::Instant;
use std::env;

const N: usize = 4096;

fn init_matrix() -> Vec<f64> {
    let t = Instant::now();
    let mut m = vec![0.0_f64; N*N];
    for (i, x) in m.iter_mut().enumerate() {
        *x = (i % 2) as f64;
    }
    let dur = t.elapsed();
    println!("init_matrix: {} micro-seconds", dur.as_secs() + dur.subsec_micros() as u64);
    return m;
}

fn sum_by_row(m: &[f64]) {
    let t = Instant::now();
    let mut s = 0.0;
    for row in 0 .. N {
        for col in 0 .. N {
            s += m[row*N + col];
        }
    }
    let dur = t.elapsed();
    println!("sum_by_row ({}): {} micro-seconds",
             s, dur.as_secs() + dur.subsec_micros() as u64);
}

fn sum_by_col(m: &[f64]) {
    let t = Instant::now();
    let mut s = 0.0;
    for row in 0 .. N {
        for col in 0 .. N {
            s += m[row + col*N];
        }
    }
    let dur = t.elapsed();
    println!("sum_by_col ({}): {} micro-seconds",
             s, dur.as_secs() + dur.subsec_micros() as u64);
}


fn main() {
    let m = init_matrix();
    for s in env::args().skip(1) {
        for b in s.bytes() {
            match b {
                b'r' => sum_by_row(&m),
                b'c' => sum_by_col(&m),
                _ => ()
            }
        }
    }
}
