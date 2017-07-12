fn main() {
    let v: Vec<i32> = vec![2, 3, 5];

    let p = &v;
    // cannot move out of borrowed content
    let w = *p;
}
