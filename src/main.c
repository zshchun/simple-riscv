#include "uart.h"
#include "stdio.h"
#include "string.h"
#include "shell.h"
#include "stdio.h"
#include "spinlock.h"
#include "timer.h"

extern void rust_test();
extern void asm_test();
extern void spin_lock_asm(int *lock);
extern void spin_unlock_asm(int *lock);
extern void sched();
int lock = 0;
int count = 0;
//void trap_handler() __attribute__ ((interrupt));
#pragma GCC optimize ("align-functions=4")
void trap_handler() {
//        sched();
        uart_putchar('.');
}

int main(int hart_id) {
//        if (hart_id) {
//                //spin_lock(&lock);
//                spin_lock_asm(&lock);
//                while (1) {
//                        sleep(1);
//                        //spin_unlock(&lock);
//                        spin_unlock_asm(&lock);
//                        __asm__ __volatile__("wfi");
//                }
//        }
        uart_init();
        asm_test();
        rust_test();
        uart_puts("Hello World!\n");
 //       spin_lock(&lock);
        printf("printf %s%c %d %d %u 0x%x\n", "test", '!', -1234, 1234, 5678, 0xabcd);
        run_shell();
        return 0;
}

