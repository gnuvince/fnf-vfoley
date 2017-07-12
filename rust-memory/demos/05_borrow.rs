fn borrow(v: &Vec<i32>) {
    // The ampersand (&) indicates that
    // the vector is only borrowed

    println!("{}", (*v).len());
    println!("{}", v.len());

    // The function ends and the ownership
    // is returned to the caller.
    // The vector [2,3,5] is NOT dropped.
}


fn main() {
    // Allocate the vector [2,3,5] and `a` is its owner.
    let a: Vec<i32> = vec![2, 3, 5];

    // Call `borrow`, but do not give up ownership of [2,3,5].
    // We obtain a "borrow" to the data of `a` with the `&` operator.
    borrow(&a);

    // Okay; `a` still owns the vector.
    println!("{:?}", a);
}
