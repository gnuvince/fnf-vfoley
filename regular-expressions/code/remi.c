/*
                                                        ,_ m _,               +------------+
                                                        |     |      ,-- i -->| ✓ SAW_REMI |
                                                        |     v     /         +------------+
   +------+        +-------+        +--------+        +---------+  /
-->| INIT |-- r -->| SAW_R |-- e -->| SAW_RE |-- m -->| SAW_REM |--
   +------+        +-------+        +--------+        +---------+  \
                                                                    \         +------------+
                                                                     `-- e -->| ✓ SAW_REME |
                                                                              +------------+

                    ,_ * _,
                    |     |
                    |     v
                   +-------+
                   | ERROR |
                   +-------+
 */


#include <stdio.h>

enum state {
    ERROR,
    INIT,
    SAW_R,
    SAW_RE,
    SAW_REM,
    SAW_REMI,
    SAW_REME
};

int check_remi(const char *str) {
    enum state transitions[7][256] = {{ERROR}};
    transitions[INIT]['r'] = SAW_R;
    transitions[SAW_R]['e'] = SAW_RE;
    transitions[SAW_RE]['m'] = SAW_REM;
    transitions[SAW_REM]['m'] = SAW_REM;
    transitions[SAW_REM]['i'] = SAW_REMI;
    transitions[SAW_REM]['e'] = SAW_REME;

    enum state curr_state = INIT;
    while (*str != 0) {
        curr_state = transitions[curr_state][*str];
        str++;
    }

    return curr_state == SAW_REMI || curr_state == SAW_REME;
}

int main(void) {
    printf("remi: %d\n", check_remi("remi"));
    printf("remmi: %d\n", check_remi("remmi"));
    printf("reme: %d\n", check_remi("reme"));
    printf("remmmmmmmmme: %d\n", check_remi("remmmmmmmmme"));


    printf("simon: %d\n", check_remi("simon"));
    printf("richard: %d\n", check_remi("richard"));
    printf("rene: %d\n", check_remi("rene"));
    printf("rei: %d\n", check_remi("rei"));
    printf("remii: %d\n", check_remi("remii"));

    return 0;
}
