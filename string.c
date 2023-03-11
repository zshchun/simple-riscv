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

int memcmp(const char *s1, const char *s2, size_t n) {
        int ret = 0;
        size_t i;
        for (i=0;i<n;i++,s1++,s2++) {
                ret = *s1 - *s2;
        }
        return ret;
}

char* lltoa(unsigned long long val, char *buf, int radix) {
        int i = 0, j, x;
        char c;
        while (val) {
                x = val % radix;
                val /= radix;
                if (x < 10)
                        buf[i] = x + '0';
                else
                        buf[i] = x + 'a';
                i++;
        }
        buf[i] = '\0';
        if (i <= 0)
                return buf;
        for (j=0;j<i/2;j++) {
                c = buf[j];
                buf[j] = buf[i-j-1];
                buf[i-j-1] = c;
        }
        return buf;
}
#endif
