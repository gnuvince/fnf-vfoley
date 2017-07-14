// [E0106]: missing lifetime specifier
//
// this function's return type contains
// a borrowed value, but the signature
// does not say whether it is borrowed
// from `v` or `w`
fn firsts_abbrev(v: &Vec<i32>, w: &Vec<i32>) -> (&i32, &i32) {
    return (&v[0], &w[0]);
}


fn firsts_full<'a, 'b>(v: &'a Vec<i32>, w: &'b Vec<i32>)
                       -> (&'a i32, &'b i32) {
    return (&v[0], &w[0]);
}
