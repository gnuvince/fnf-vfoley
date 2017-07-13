fn main() {
    let v: Vec<String> = vec!["foo".to_string(),
                              "bar".to_string()];
    // [E0507]: cannot move out of indexed content
    let s: String = v[0];
    println!("{}", s);
}
