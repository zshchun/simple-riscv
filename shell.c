#include <stddef.h>
#include "uart.h"
#include "string.h"
#include "timer.h"

char cmd_buf[128];
char num[128];
char test_str[] = "strcpy test\n";

void help() {
        uart_puts("List commands\n");
        uart_puts("help : help commands\n");
}
void test() {
        char arr[64];
        memset(arr, 'A', 20);
        arr[20] = '\n';
        uart_puts(arr);
        strcpy(arr, test_str);
        uart_puts(arr);
}

void run_shell() {
        unsigned long long now;
        while (1) {
                now = timer_read() / 1000LL;
                lltoa(now, num, 10);
                uart_putchar('[');
                uart_puts(num);
                uart_puts("] > ");
                uart_gets(cmd_buf, sizeof(cmd_buf));
                if (!strcmp(cmd_buf, "help")) {
                        help();
                } else if (!strcmp(cmd_buf, "test")) {
                        test();
                }
                uart_putchar('\n');
        }
}
