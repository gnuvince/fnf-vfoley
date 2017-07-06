fn main() {
    // 47 is "allocated" and `a` owns it.
    let a: i32 = 47;

    // i32's are small and simple enough that
    // it's better to copy rather than move;
    // `b` owns a copy of 47, and `a` still
    // owns its copy.
    let b = a;

    println!("{}", b); // OK
    println!("{}", a); // OK
}
