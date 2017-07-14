fn main() {
    let r: &i32;
    {
        let v = vec![2, 3, 5];
        r = &(v[0])
    };
    // `v` does not live long enough
    // (`v` dropped here while still borrowed)
}
