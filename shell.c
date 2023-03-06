#include <stddef.h>
#include "uart.h"
#include "string.h"
#include "timer.h"

char buf[128];
char msg[128];
void help() {
        uart_puts("List commands\n");
        uart_puts("help : help commands\n");
}

void run_shell() {
        unsigned long long now;
        while (1) {
                now = timer_read() / 1000LL;
                lltoa(now, msg, 10);
                uart_putchar('[');
                uart_puts(msg);
                uart_puts("] > ");
                uart_gets(buf, sizeof(buf));
                if (!strcmp(buf, "help")) {
                        help();
                }
                uart_putchar('\n');
        }
}
