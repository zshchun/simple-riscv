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
        uart_puts("test : test commands\n");
        uart_puts("echo : echo message\n");
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
                __asm__ __volatile__("wfi");
                uart_gets(cmd_buf, sizeof(cmd_buf));
                if (!strcmp(cmd_buf, "help")) {
                        help();
                } else if (!strcmp(cmd_buf, "test")) {
                        test();
                } else if (!memcmp(cmd_buf, "echo", sizeof("echo")-1)) {
                        uart_putchar('\n');
                        uart_puts(cmd_buf+5);
                }
                uart_putchar('\n');
        }
}
