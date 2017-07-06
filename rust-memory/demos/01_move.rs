fn main() {
    // A vector is allocated and `a` owns it.
    let a: Vec<i32> = vec![2, 3, 5];

    // The ownership of the vector [2,3,5] is passed
    // from `a` to `b`; `a` owns nothing anymore.
    let b = a;

    // This is fine.
    println!("{:?}", b);

    // This is an error: `a` is no longer initialized.
    // use of moved value: `a` (value used here after move) [E0382]
    println!("{:?}", a);
}
