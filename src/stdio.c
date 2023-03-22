#include "uart.h"
#include "string.h"
#include "stdbool.h"
#define PRINT_BUF_LEN 8192
char print_buf[PRINT_BUF_LEN+1];
int printf(const char *format, ...) {
        int i = 0;
        const char *p = format;
        char *s;
        char c;
        unsigned long lu;
        unsigned int u;
        long lv;
        int v;
        bool l_prefix;
        __builtin_va_list argv;
        __builtin_va_start(argv, format);
        while (*p && i < PRINT_BUF_LEN) {
                if (*p == '%') {
                        l_prefix = false;
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
                                case 'l':
                                        l_prefix = true;
                                        __attribute__((fallthrough));
                                case 'd':
                                        if (l_prefix) {
                                                lv = __builtin_va_arg(argv, long);
                                                itoa(lv, &print_buf[i], 10);
                                        } else {
                                                v = __builtin_va_arg(argv, int);
                                                itoa(v, &print_buf[i], 10);
                                        }
                                        i += strlen(&print_buf[i]);
                                        break;
                                case 'u':
                                        if (l_prefix) {
                                                lu = __builtin_va_arg(argv, unsigned long);
                                                lltoa(lu, &print_buf[i], 10);
                                        } else {
                                                u = __builtin_va_arg(argv, unsigned int);
                                                lltoa(u, &print_buf[i], 10);
                                        }
                                        i += strlen(&print_buf[i]);
                                        break;
                                case 'x':
                                        if (l_prefix) {
                                                lu = __builtin_va_arg(argv, unsigned long);
                                                lltoa(lu, &print_buf[i], 16);
                                        } else {
                                                u = __builtin_va_arg(argv, unsigned int);
                                                lltoa(u, &print_buf[i], 16);
                                        }
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
