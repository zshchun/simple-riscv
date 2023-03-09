#include "uart.h"
#include "string.h"
#include "shell.h"
#include "spinlock.h"
#include "timer.h"

extern void rust_test();
int lock = 0;

int main(int hart_id) {
        if (hart_id) {
                spin_lock(&lock);
                while (1) {
                        spin_unlock(&lock);
                        __asm__ __volatile__("wfi");
                }
        }
        uart_init();
        rust_test();
        uart_puts("Hello World!\n");
        run_shell();
        return 0;
}

