#include <stddef.h>
#include "uart.h"
#include "string.h"

char buf[128];
void help() {
        uart_puts("List commands\n");
        uart_puts("help : help commands\n");
}

void run_shell() {
        while (1) {
                uart_puts("> ");
                uart_gets(buf, sizeof(buf));
                if (!strcmp(buf, "help")) {
                        help();
                }
                uart_putchar('\n');
        }
}
