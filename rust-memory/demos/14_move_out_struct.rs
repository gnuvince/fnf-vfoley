#[derive(Debug)]
struct Person {
    name: String,
    job: String,
}

fn main() {
    let p = Person { name: "Remi".to_string(),
                     job: "Chaos Engineer".to_string() };

    // Ownership of the string "Chaos Engineer
    // is moved from the `job` field to `s`.
    let s = p.job;
    println!("{}", s);

    // [E0382]: use of moved value: `p.job`
    println!("{}", p.job);

    // [E0382]: use of partially moved value:
    // `p` (value used here after move)
    println!("{:?}", p);
}
