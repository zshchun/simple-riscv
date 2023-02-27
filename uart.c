#define UART_BASE 0x10000000
#define THR 0
#define IER 1
#define FCR 2
#define LCR 3
#define LSR 5
#define UART_REG(addr) ((volatile unsigned char*)(UART_BASE+addr))
#define UART_WRITE(addr, val) (*UART_REG(addr) = val)
#define UART_READ(addr) (*UART_REG(addr))

void uart_putchar(char c) {
        while ((UART_READ(LSR) & 1<<5) == 0) { ; }
        UART_WRITE(THR, c);
}

void uart_puts(char *s) {
        while (*s) {
                uart_putchar(*s);
                s++;
        }
}

void uart_init() {
        // Set word size = 8-bits
        UART_WRITE(LCR, 3);
        // Set FIFO
        UART_WRITE(FCR, 1);
        // Enable interrupt
        UART_WRITE(IER, 1);
}
