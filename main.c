#include "uart.h"
#include "string.h"
#include "shell.h"
#include "spinlock.h"
#include "timer.h"

extern void rust_test();
char arr[128];
char test_str[] = "strcpy test\n";

int lock = 0;

int main(int hart_id) {
        if (hart_id) {
                while (1) {
                        spin_lock(&lock);
                        __asm__ __volatile__("wfi");
                }
        }
        uart_init();
        rust_test();
        memset(arr, 'A', 20);
        arr[20] = '\n';
        uart_puts(arr);
        strcpy(arr, test_str);
        uart_puts(arr);
        uart_puts("Hello World!\n");
        timer_read();
        run_shell();
        return 0;
}

