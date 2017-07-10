fn borrow(v1: &Vec<i32>, v2: &Vec<i32>) {
    println!("{}", v1.len() + v2.len());
}

fn main() {
    let a: Vec<i32> = vec![2, 3, 5];

    let b1 = &a;
    let b2 = &a;

    borrow(b1, b2);
}
