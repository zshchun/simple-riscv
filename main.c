#include "uart.h"

extern void rust_test();

int main(int hart_id) {
        if (hart_id) {
                while (1) {
                        __asm__ __volatile__("wfi");
                }
        }
        rust_test();
        uart_puts("Hello World!\n");
        return 0;
}

