fn main() {
    {
        // A vector is allocated here and `v` owns it.
        let v = vec![2, 3, 5];
        println!("{:?}", v);
    }
    // The variable `v` goes out of scope
    // and the memory it owns is dropped.
}
