#include "scheduler.h"
void sched(task_t *task) {
        register unsigned int sp __asm__("sp");
        task_t *context = (sp & ~8191);
        __asm__ __volatile__( "sd ra, 0(sp)\n"
        : : "r" (context) : "memory");
}
