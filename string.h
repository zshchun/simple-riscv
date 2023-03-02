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

#endif
