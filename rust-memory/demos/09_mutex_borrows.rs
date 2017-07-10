fn main() {
    let mut v: Vec<i32> = vec![2, 3, 5];

    {
        let shared_p = &v;
        // error[E0502]: cannot borrow `v` as mutable
        // because it is also borrowed as immutable
        let mut_p = &mut v;
    }

    {
        let mut_p = &mut v;
        // error[E0502]: cannot borrow `v` as immutable
        // because it is also borrowed as mutable
        let shared_p = &v;
    }
}
