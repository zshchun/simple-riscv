        .section .text
        .global asm_test
        .global spin_lock_asm
        .global spin_unlock_asm
asm_test:
        addi sp, sp, -8
        sd ra, 0(sp)
        la a0, text1
        jal uart_puts
        ld ra, 0(sp)
        addi sp, sp, 8
        ret

spin_lock_asm:
        li t0, 1
1:
        amoswap.w.aq t0, t0, 0(a0)
        bnez t0, 1b

spin_unlock_asm:
        amoswap.w.rl zero, zero, 0(a0)

        .section .rodata
text1:
        .asciz "Hello RISC-V assembly!\n"
