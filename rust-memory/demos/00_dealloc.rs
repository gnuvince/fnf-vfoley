fn main() {
    {
        // A vector is allocated here and `v` owns it.
        let v = vec![0; 1024*1024*1024];
        println!("{}", v.len());
    }
    // The variable `v` goes out of scope
    // and the memory it owns is released.
}
