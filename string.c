#ifndef STRING_H_
#define STRING_H_
#include <stddef.h>

void *memcpy(void *dest, const void *src, size_t n) {
        unsigned char *s = (void*)src;
        unsigned char *d = dest;
        while (n != 0) {
                *d = *s;
                d++;
                s++;
                n--;
        }
        return dest;
}

void *memset(void *s, int c, size_t n) {
        unsigned char *p = s;
        while (n != 0) {
                *p = c;
                p++;
                n--;
        }
        return s;
}

char *strcpy(char *dst, const char *src) {
        while (*src) {
                *dst = *src;
                src++;
                dst++;
        }
        *dst = '\0';
        return dst;
}

size_t strlen(const char *s) {
        size_t size = 0;
        while (*s) {
                s++;
                size++;
        }
        return size;
}

int strcmp(const char *s1, const char *s2) {
        int ret;
        while (*s1 || *s2) {
                ret = *s1 - *s2;
                if (ret)
                        return ret;
                s1++;
                s2++;
        }
        return ret;
}

#endif
