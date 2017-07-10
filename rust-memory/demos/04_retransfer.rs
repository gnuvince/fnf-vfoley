fn retransfer(v: Vec<i32>) -> Vec<i32> {
    // `v` becomes the owner of the vector [2,3,5]
    println!("{:?}", v);

    // We transfer ownership of [2,3,5] back to the caller.
    return v;
}


fn main() {
    // Allocate the vector [2,3,5] and `a` is its owner.
    let a: Vec<i32> = vec![2, 3, 5];

    // Call `retransfer` and give ownership the vector that
    // `a` owns ("move `a`").
    // Give ownership to a new `a` (NOT THE SAME AS BEFORE).
    let a = retransfer(a);

    // Okay; the "second" `a` owns the vector.
    println!("{:?}", a);
}
