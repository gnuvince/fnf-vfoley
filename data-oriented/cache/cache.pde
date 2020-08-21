int NotStarted = 0;
int L1 = 1;
int L2 = 2;
int Ram = 3;
int Done = 4;

int currentExample = NotStarted;
int x[] = { 0, 100, 100, 100, 0 };
int dx[] = { 0, 100, 10, 1, 0 };
int rad = 25;

int start, finish;

PFont font;

void setup() {
    size(1000, 600);
    start = 100;
    finish = width - 100;

    font = createFont("Hack-Regular.ttf", 32);
    textFont(font);
    textAlign(CENTER, CENTER);
}

void draw() {
    background(0);

    // Start and finish lines
    stroke(255);
    fill(255);
    text("L1", 35, 150);
    text("L2", 35, 300);
    text("RAM", 35, 450);
    line(start, 100, start, 500);
    line(finish, 100, finish, 500);

    // Blocks
    noStroke();
    fill(0, 64, 128);
    rectMode(RADIUS);
    rect(x[L1], 100 + 2*rad, rad, rad);
    rect(x[L2], 250 + 2*rad, rad, rad);
    rect(x[Ram], 400 + 2*rad, rad, rad);

    // Advance block
    x[currentExample] = min(finish, x[currentExample]+dx[currentExample]);
}

void keyPressed() {
    if (key == ' ') {
        currentExample = min(Done, currentExample + 1);
    } else if (key == 'r') {
        currentExample = NotStarted;
        x[L1] = start;
        x[L2] = start;
        x[Ram] = start;
    }

}
