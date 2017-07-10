fn main() {
    let mut v: Vec<i32> = vec![2, 3, 5];

    // OK
    let p1 = &mut v;

    // Error, a mutable borrow already exists
    //
    // error[E0499]: cannot borrow `v` as mutable more
    // than once at a time
    let p2 = &mut v;
}
