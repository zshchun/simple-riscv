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

#endif
