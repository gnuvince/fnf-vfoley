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
        draw_string(s);
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
}


void draw_string(String s) {
    textFont(ubuntu);
    stroke(212);
    for (int i = 0; i < s.length(); ++i) {
        fill(0, 0, 0, 255);
        rect(i * sq_size + 8, height/2 - sq_size/2, sq_size, sq_size);
        fill(255);
        text(s.charAt(i), i * sq_size + sq_size/3 + 1, 16 + height/2);
    }
}

void draw_head(int i, String text) {
    fill(dfa.head_color());
    ellipse(sq_size/2 + i * sq_size + 8, height/2 + sq_size + 8, sq_size, sq_size);
    fill(255);
    text(text, sq_size/3 + i * sq_size + 8, height/2 + sq_size + text_size/2);
}


PFont ubuntu;
int text_size = 64;
int sq_size = 96;
RemiDFA dfa;

void setup() {
    size(1000, 400);
    ubuntu = createFont("Iosevka Term", text_size);
    textSize(text_size);
    strokeWeight(4);
    dfa = new RemiDFA("remiiiiii");
}

void draw() {
    background(0);
    dfa.draw();
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
