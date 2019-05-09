use std::time::{Instant};

const ITERS: usize = 5000;
type Element = u64;
const SIZE: Element = 255;

fn linear_search(arr: &[Element], target: Element) -> bool {
    arr.iter().any(|x| *x == target)
}

fn binary_search(arr: &[Element], target: Element) -> bool {
    let mut lo = 0;
    let mut hi = arr.len();

    while lo < hi {
        let mid = (lo + hi) / 2;
        let x = arr[mid];
        if x < target {
            lo = mid+1;
        } else if x > target {
            hi = mid;
        } else {
            return true;
        }
    }

    return false;
}

fn main() {
    for size in 0 ..= SIZE {
        let v: Vec<Element> = (0 ..= (size as Element)).collect();

        let top = Instant::now();
        let mut linear_matches = 0;
        for _ in 0 .. ITERS {
            for target in 0 ..= SIZE {
                let found = linear_search(&v, target);
                linear_matches += found as usize;
            }
        }
        let linear_dur = top.elapsed();

        let top = Instant::now();
        let mut binary_matches = 0;
        for _ in 0 .. ITERS {
            for target in 0 ..= SIZE {
                let found = binary_search(&v, target);
                binary_matches += found as usize;
            }
        }
        let binary_dur = top.elapsed();

        assert_eq!(linear_matches, binary_matches);

        println!("{} {}.{:09} {}.{:09}",
                 size,
                 linear_dur.as_secs(), linear_dur.subsec_nanos(),
                 binary_dur.as_secs(), binary_dur.subsec_nanos());
    }
}
