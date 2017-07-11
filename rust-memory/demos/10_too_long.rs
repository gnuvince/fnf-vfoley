fn main() {
    let r = {
        let v = vec![2, 3, 5];
        &(v[0])
    };
    // `v` does not live long enough
    // (`v` dropped here while still borrowed)
}
