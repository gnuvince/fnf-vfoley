use std::time::Instant;

const N: usize = 1<<23;

fn main() {
    let mut u: Vec<i64> = vec![0; N];
    let mut v: Vec<i64> = vec![0; N];

    for bits in 16 ..= 23 {
        let n = 1 << bits;
        for (x, y) in &mut v[..n].iter_mut().zip(&mut u) {
            let r = rand::random::<i64>();
            *x = r;
            *y = r;
        }

        let top = Instant::now();
        &mut u[..n].sort();
        let merge_sort_time = top.elapsed();

        let top = Instant::now();
        &mut v[..n].sort_unstable();
        let quick_sort_time = top.elapsed();

        println!("{} {}.{:06} {}.{:06} {:.02}",
                 n,
                 merge_sort_time.as_secs(), merge_sort_time.subsec_micros(),
                 quick_sort_time.as_secs(), quick_sort_time.subsec_micros(),
                 (merge_sort_time.as_micros() as f64 / quick_sort_time.as_micros() as f64));
    }
}
