fn first_abbrev(v: &Vec<i32>) -> &i32 {
    return &v[0];
}

fn first_full<'a>(v: &'a Vec<i32>) -> &'a i32 {
    return &v[0];
}
