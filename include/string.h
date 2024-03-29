#ifndef STRING_H_
#define STRING_H_
#include <stddef.h>

void *memcpy(void *dest, const void *src, size_t n);
void *memset(void *s, int c, size_t n);
char *strcpy(char *dst, const char *src);
size_t strlen(const char *s);
int strcmp(const char *s1, const char *s2);
int memcmp(const char *s1, const char *s2, size_t n);
char* itoa(int val, char *buf, int radix);
char* lltoa(unsigned long long val, char *buf, int radix);

#endif
