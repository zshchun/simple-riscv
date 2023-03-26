#include <stdint.h>
typedef struct __regs {
        uint64_t a0;
        uint64_t a1;
        uint64_t a2;
        uint64_t a3;
        uint64_t a4;
        uint64_t a5;
        uint64_t a6;
} regs_t;

typedef struct __task {
        regs_t reg;
} task_t;

void sched(task_t *task);
