use std::env::args;
use std::error::Error;
use std::io::{self, BufRead};
use std::time::Instant;

const ITERS: usize = 16;

enum Num {
    Int(i32),
    Float(f32),
}

trait NumTrait {
    fn to_float(&self) -> f32;
}

impl NumTrait for i32 {
    fn to_float(&self) -> f32 {
        *self as f32
    }
}

impl NumTrait for f32 {
    fn to_float(&self) -> f32 {
        *self
    }
}

fn main() -> Result<(), Box<dyn Error>> {
    let args: Vec<String> = args().collect();
    if args[1] == "enum" {
        do_enum()?;
    } else if args[1] == "do" {
        do_do()?;
    } else if args[1] == "trait" {
        do_trait()?;
    }
    return Ok(());
}

fn do_enum() -> Result<(), Box<dyn Error>> {
    let stdin = io::stdin();
    let stdin = stdin.lock();
    let mut v: Vec<Num> = Vec::with_capacity(4096);

    let top = Instant::now();
    for line in stdin.lines() {
        let line = line?;
        match line.parse::<i32>() {
            Ok(i) => v.push(Num::Int(i)),
            Err(_) => {
                match line.parse::<f32>() {
                    Ok(f) => v.push(Num::Float(f)),
                    Err(_) => { }
                }
            }
        }
    }
    eprintln!("read time: {:?}", top.elapsed());

    for _ in 0 .. ITERS {
        let top = Instant::now();
        let mut sum: f32 = 0.0;
        for n in &v {
            match *n {
                Num::Int(i) => sum += i as f32,
                Num::Float(f) => sum += f,
            }
        }
        println!("sum: {}", sum);
        eprintln!("sum time: {:?}", top.elapsed());
    }

    return Ok(());
}

fn do_do() -> Result<(), Box<dyn Error>> {
    let stdin = io::stdin();
    let stdin = stdin.lock();
    let mut ints: Vec<i32> = Vec::with_capacity(4096);
    let mut floats: Vec<f32> = Vec::with_capacity(4096);

    let top = Instant::now();
    for line in stdin.lines() {
        let line = line?;
        match line.parse::<i32>() {
            Ok(i) => ints.push(i),
            Err(_) => {
                match line.parse::<f32>() {
                    Ok(f) => floats.push(f),
                    Err(_) => { }
                }
            }
        }
    }
    eprintln!("read time: {:?}", top.elapsed());

    for _ in 0 .. ITERS {
        let top = Instant::now();
        let mut sum: f32 = 0.0;
        for n in &ints { sum += *n as f32; }
        for n in &floats { sum += *n; }
        println!("sum: {}", sum);
        eprintln!("sum time: {:?}", top.elapsed());
    }

    return Ok(());
}

fn do_trait() -> Result<(), Box<dyn Error>> {
    let stdin = io::stdin();
    let stdin = stdin.lock();
    let mut v: Vec<Box<dyn NumTrait>> = Vec::with_capacity(4096);

    let top = Instant::now();
    for line in stdin.lines() {
        let line = line?;
        match line.parse::<i32>() {
            Ok(i) => v.push(Box::new(i)),
            Err(_) => {
                match line.parse::<f32>() {
                    Ok(f) => v.push(Box::new(f)),
                    Err(_) => { }
                }
            }
        }
    }
    eprintln!("read time: {:?}", top.elapsed());

    for _ in 0 .. ITERS {
        let top = Instant::now();
        let mut sum: f32 = 0.0;
        for n in &v {
            sum += n.to_float();
        }
        println!("sum: {}", sum);
        eprintln!("sum time: {:?}", top.elapsed());
    }

    return Ok(());
}
