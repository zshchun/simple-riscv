#include "uart.h"
#include "string.h"

extern void rust_test();
char arr[128];
char test_str[] = "memcpy test\n";

int main(int hart_id) {
        if (hart_id) {
                while (1) {
                        __asm__ __volatile__("wfi");
                }
        }
        uart_init();
        rust_test();
        memset(arr, 'A', 10);
        arr[10] = '\n';
        uart_puts(arr);
        memcpy(arr, test_str, sizeof(test_str));
        uart_puts(arr);
        uart_puts("Hello World!\n");
        return 0;
}

