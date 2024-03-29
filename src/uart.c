#include <stddef.h>
#include "reg.h"
#define UART_BASE 0x10000000
#define THR 0
#define RHR 0
#define IER 1
#define FCR 2
#define LCR 3
#define LSR 5
#define UART_WRITE(addr, val) WRITE_REG(UART_BASE, addr, val, unsigned char)
#define UART_READ(addr) READ_REG(UART_BASE, addr, unsigned char)


void uart_putchar(char c) {
        while ((UART_READ(LSR) & 1<<5) == 0) { ; }
        UART_WRITE(THR, c);
}

char uart_getchar() {
        while ((UART_READ(LSR) & 1) == 0) { ; }
        return UART_READ(RHR);
}

// #pragma GCC optimize ("align-functions=4")
void uart_puts(char *s) {
        while (*s) {
                uart_putchar(*s);
                s++;
        }
}

char* uart_gets(char *s, size_t n) {
        unsigned int i;
        for (i=0;i<n-1;i++) {
                s[i] = uart_getchar();
                uart_putchar(s[i]);
                if (s[i] == '\n' || s[i] == '\r' || s[i] == '\0') {
                        break;
                } else if (s[i] == 127 || s[i] == 8) {
                        if (i > 0) {
                                uart_puts("\b \b");
                                s[i] = '\0';
                                i -= 2;
                        }
                }
        }
        s[i] = '\0';
        return s;
}

void uart_init() {
        // Set word size = 8-bits
        UART_WRITE(LCR, 3);
        // Set FIFO
        UART_WRITE(FCR, 1);
        // Enable interrupt
        UART_WRITE(IER, 1);
}
