class Node {
    int x, y, diam;
    String label;
    boolean active;

    Node(String label, int x, int y, int diam) {
        this.label = label;
        this.x = x;
        this.y = y;
        this.diam = diam;
    }

    void draw() {
        stroke(255);
        strokeWeight(4);
        fill(0, 0, active ? 192 : 64);
        ellipse(x, y, diam, diam);
        fill(255);
        textAlign(CENTER, CENTER);
        textSize(32);
        text(label, x, y);
    }
}


class RemiDFA {
    private int Error = 0;
    private int Start = 1;
    private int SawR = 2;
    private int SawRE = 3;
    private int SawREM = 4;
    private int Success = 5;

    public String s;
    public int str_index = 0;

    public int curr_state = Start;
    public int[][] transition;

    RemiDFA(String s) {
        this.reset();
        this.s = s;
        transition = new int[7][128];
        transition[Start]['r'] = SawR;
        transition[SawR]['e'] = SawRE;
        transition[SawRE]['m'] = SawREM;
        transition[SawREM]['m'] = SawREM;
        transition[SawREM]['i'] = Success;
        transition[SawREM]['e'] = Success;
    }

    void draw() {
        draw_tape(s);
        draw_head(str_index, "" + curr_state);
    }

    boolean finished() {
        return str_index >= s.length();
    }

    void advance() {
        if (!finished()) {
            curr_state = transition[curr_state][s.charAt(str_index)];
            str_index += 1;
        }
    }

    void reset() {
        curr_state = Start;
        str_index = 0;
    }

    color head_color() {
        if (curr_state == Error) return color(127, 0, 0);
        if (curr_state == Success) return color(0, 127, 0);
        return color(127);
    }

    String acceptString() {
        if (finished() && curr_state == 5) return "YES";
        if (finished() && curr_state != 5) return "NO";
        return "";
    }
}


void draw_tape(String s) {
    textSize(text_size);
    textAlign(CENTER, CENTER);
    stroke(212);
    for (int i = 0; i < s.length(); ++i) {
        fill(0, 0, 0, 255);
        int w = (1+i) * sq_size;
        int h = 3*height/4 - sq_size/2;
        rect(w, h, sq_size, sq_size);
        fill(255);
        text(s.charAt(i), w+sq_size/2, h+sq_size/2);
    }
}

void draw_head(int i, String text) {
    fill(dfa.head_color());
    int x = sq_size/2 + (1+i) * sq_size;
    int y = 3*height/4 + sq_size + 8;
    ellipse(x, y, sq_size, sq_size);
    fill(255);
    textAlign(CENTER, CENTER);
    text(text, x, y);
}


PFont iosevka;
int text_size = 64;
int sq_size = 96;
RemiDFA dfa;

int node_w = 150;

Node[] nodes;

void setup() {
    size(1600, 1000);

    // Font
    iosevka = createFont("Iosevka Term", text_size);
    textFont(iosevka);

    dfa = new RemiDFA("remise");
    nodes = new Node[6];
    int node_h = 3 * node_w;
    nodes[0] = new Node("Error\n0", (int) (node_w + node_w*3.0), 3*node_w, node_w);
    nodes[1] = new Node("Start\n1", node_w, node_w, node_w);
    nodes[2] = new Node("SawR\n2", (int) (node_w + node_w*1.5), node_w, node_w);
    nodes[3] = new Node("SawRE\n3", (int) (node_w + node_w*3.0), node_w, node_w);
    nodes[4] = new Node("SawREM\n4", (int) (node_w + node_w*4.5), node_w, node_w);
    nodes[5] = new Node("Success\n5\n✓", (int) (node_w + node_w*6.0), node_w, node_w);
}

void draw_edge(Node left, Node right, String label) {
    line(left.x + node_w/2,
         left.y,
         right.x - node_w/2,
         right.y);
    textSize(32);
    textAlign(CENTER, TOP);
    text(label,
         (left.x + right.x)/2,
         left.y);
}

void draw() {
    background(0);
    dfa.draw();
    for (int i = 0; i < nodes.length; ++i) {
        nodes[i].active = (i == dfa.curr_state);
        nodes[i].draw();
    }
    draw_edge(nodes[1], nodes[2], "r");
    draw_edge(nodes[2], nodes[3], "e");
    draw_edge(nodes[3], nodes[4], "m");
    draw_edge(nodes[4], nodes[5], "i,e");
    noFill();

    // m self loop
    beginShape();
    curveVertex(nodes[4].x - 15, nodes[4].y + nodes[4].diam/2);
    curveVertex(nodes[4].x - 15, nodes[4].y + nodes[4].diam/2);
    curveVertex(nodes[4].x - 40, nodes[4].y + nodes[4].diam);
    curveVertex(nodes[4].x + 40, nodes[4].y + nodes[4].diam);
    curveVertex(nodes[4].x + 15, nodes[4].y + nodes[4].diam/2);
    curveVertex(nodes[4].x + 15, nodes[4].y + nodes[4].diam/2);
    endShape();
    textSize(32);
    textAlign(CENTER, TOP);
    text("m", nodes[4].x, nodes[4].y + nodes[4].diam + 8);

    // error self loop
    beginShape();
    curveVertex(nodes[0].x - 15, nodes[0].y + nodes[0].diam/2);
    curveVertex(nodes[0].x - 15, nodes[0].y + nodes[0].diam/2);
    curveVertex(nodes[0].x - 40, nodes[0].y + nodes[0].diam);
    curveVertex(nodes[0].x + 40, nodes[0].y + nodes[0].diam);
    curveVertex(nodes[0].x + 15, nodes[0].y + nodes[0].diam/2);
    curveVertex(nodes[0].x + 15, nodes[0].y + nodes[0].diam/2);
    endShape();
    textSize(32);
    textAlign(CENTER, TOP);
    text("*", nodes[0].x, nodes[0].y + nodes[0].diam + 8);

    rect(width-400, height/2, 300, 120);
    textAlign(LEFT, BOTTOM);
    text("Accept?", width-400, height/2);
    textSize(108);
    textAlign(LEFT, CENTER);
    text(dfa.acceptString(), width-400 + 32, height/2 + 50);
}


void mouseClicked() {
    dfa.advance();
}

void keyPressed() {
    switch (keyCode) {
    case ' ': dfa.advance(); break;
    case 'R': dfa.reset(); break;
    }
}
