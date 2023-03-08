#include "reg.h"
#define TIMER_BASE 0x101000
#define RTC_TIME_LOW            0x00
#define RTC_TIME_HIGH           0x04

#define TIMER_WRITE(addr, val) WRITE_REG(TIMER_BASE, addr, val, unsigned int)
#define TIMER_READ(addr) READ_REG(TIMER_BASE, addr, unsigned int)

unsigned long long timer_read() {
        unsigned long long low = TIMER_READ(RTC_TIME_LOW);
        unsigned long long high = TIMER_READ(RTC_TIME_HIGH);
        unsigned long long t = (high << 32) | low;
        return t;
}
void nanosleep(unsigned long long nsec) {
        unsigned long long t = timer_read();
        while (timer_read() - t < nsec)
                ;
}
void sleep(unsigned long long sec) {
        unsigned long long t = timer_read();
        while ((timer_read() - t) < sec * 1000000000ULL)
                ;
}
