#include <stdio.h>

void vip_club(void) {
    printf("It's a secret to everybody\n");
}

void greet(void) {
    int love;
    char name[8];

    love = 0;

    printf("Your name? ");
    gets(name);
    printf("Hello, %s\n", name);

    if (love)
        printf("I LOVE YOU!\n");
}

int main(void) {
    greet();
    return 0;
}
