#define UART_BASE 0x10000000
#define THR 0
#define FCR 2
#define LCR 3
#define LSR 5
#define REG(addr) ((volatile unsigned char*)(addr))

char array[128];

void uart_putc(char c) {
        while ((*REG(UART_BASE+LSR) & 1<<5) == 0) { ; }
        *REG(UART_BASE+THR) = c;
}

void print(char *s) {
        while (*s) {
                uart_putc(*s);
                s++;
        }
}

int main() {
        print("Hello World!\n");
        return 0;
}
