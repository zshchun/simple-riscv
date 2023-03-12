#include <stddef.h>
#ifndef UART_H_
#define UART_H_

void uart_putchar(char c);
char uart_getchar();
void uart_puts(char *s);
char* uart_gets(char *s, size_t n);
void uart_init();

#endif
