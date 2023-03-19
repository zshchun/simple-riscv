#include "uart.h"
#include "stdio.h"
#include "string.h"
#include "shell.h"
#include "stdio.h"
#include "spinlock.h"
#include "timer.h"

extern void rust_test();
extern void asm_test();
int lock = 0;
void trap_handler() {
        uart_puts("Trap!\n");
        while (1) { ; }
}

int main(int hart_id) {
        if (hart_id) {
                spin_lock(&lock);
                while (1) {
                        spin_unlock(&lock);
                        __asm__ __volatile__("wfi");
                }
        }
        asm_test();
        uart_init();
        rust_test();
        uart_puts("Hello World!\n");
        printf("printf %s%c\n", "test", '!');
        run_shell();
        return 0;
}

