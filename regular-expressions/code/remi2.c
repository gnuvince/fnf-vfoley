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
    int c;
    enum state curr_state = INIT;

    while ((c = *str++) != 0) {
        switch (curr_state) {
        case ERROR:
            break;
        case INIT:
            switch (c) {
            case 'r':
                curr_state = SAW_R;
                break;
            default:
                curr_state = ERROR;
                break;
            }
            break;
        case SAW_R:
            switch (c) {
            case 'e':
                curr_state = SAW_RE;
                break;
            default:
                curr_state = ERROR;
            }
            break;
        case SAW_RE:
            switch (c) {
            case 'm':
                curr_state = SAW_REM;
                break;
            default:
                curr_state = ERROR;
            }
            break;
        case SAW_REM:
            switch (c) {
            case 'm':
                curr_state = SAW_REM;
                break;
            case 'i':
                curr_state = SAW_REMI;
                break;
            case 'e':
                curr_state = SAW_REME;
                break;
            default:
                curr_state = ERROR;
            }
            break;
        case SAW_REMI:
            switch (c) {
            case 0:
                break;
            default:
                curr_state = ERROR;
            }
            break;
        case SAW_REME:
            switch (c) {
            case 0:
                break;
            default:
                curr_state = ERROR;
            }
            break;
        }
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
