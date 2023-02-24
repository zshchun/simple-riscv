#define UART_BASE 0x10000000
#define THR 0
#define FCR 2
#define LCR 3
#define LSR 5
#define REG(addr) ((volatile unsigned char*)(addr))

char array[128];
extern void rust_test();

void uart_putchar(char c) {
        while ((*REG(UART_BASE+LSR) & 1<<5) == 0) { ; }
        *REG(UART_BASE+THR) = c;
}

void uart_puts(char *s) {
        while (*s) {
                uart_putchar(*s);
                s++;
        }
}

int main() {
        uart_puts("Hello World!\n");
//        rust_test();
        return 0;
}

