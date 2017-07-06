fn take(v: Vec<i32>) {
    // `v` becomes the owner of the vector [2,3,5]
    println!("{}", v.len());

    // `v` goes out of scope and the vector [2,3,5]
    // is released.
}


fn main() {
    // Allocate the vector [2,3,5] and `a` is its owner.
    let a: Vec<i32> = vec![2, 3, 5];

    // Call `take` and give ownership the vector
    // that `a` owns ("move `a`").
    take(a);

    // Invalid: `a` is uninitialized.
    println!("{:?}", a);
}
