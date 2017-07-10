fn incr(p: &mut i32) {
    *p += 1;
}

fn main() {
    // To get a mutable borrow, `v` itself must be mutable.
    let mut v: Vec<i32> = vec![2, 3, 5];

    // Get a mutable borrow to the first element of `v`.
    // NB: borrowing one element of a vector borrows the whole vector!
    incr(&mut v[0]);

    println!("{:?}", v);
}
