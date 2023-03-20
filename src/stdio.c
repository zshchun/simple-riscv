#include "uart.h"
#include "string.h"
#define PRINT_BUF_LEN 8192
char print_buf[PRINT_BUF_LEN+1];
int printf(const char *format, ...) {
        int i = 0;
        const char *p = format;
        char *s;
        char c;
        unsigned int u;
        int v;
        __builtin_va_list argv;
        __builtin_va_start(argv, format);
        while (*p && i < PRINT_BUF_LEN) {
                if (*p == '%') {
                        p++;
                        switch(*p) {
                                case 'c':
                                        c = __builtin_va_arg(argv, unsigned int);
                                        print_buf[i++] = c;
                                        break;
                                case 's':
                                        s = __builtin_va_arg(argv, char*);
                                        while (*s) {
                                                print_buf[i++] = *s;
                                                s++;
                                        }
                                        break;
                                // TODO l prefix
                                // TODO type
                                case 'd':
                                        v = __builtin_va_arg(argv, int);
                                        itoa(v, &print_buf[i], 10);
                                        i += strlen(&print_buf[i]);
                                        break;
                                case 'u':
                                        u = __builtin_va_arg(argv, unsigned int);
                                        lltoa(u, &print_buf[i], 10);
                                        i += strlen(&print_buf[i]);
                                        break;
                                case 'x':
                                        u = __builtin_va_arg(argv, unsigned int);
                                        lltoa(u, &print_buf[i], 16);
                                        i += strlen(&print_buf[i]);
                                        break;
                        }
                } else {
                        print_buf[i++] = *p;
                }
                p++;
        }
        print_buf[i] = '\0';
        __builtin_va_end(argv);
        uart_puts(print_buf);
        return i;

}
