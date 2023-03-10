        .section .text
        .global asm_test
asm_test:
        addi sp, sp, -8
        sd ra, 0(sp)
        la a0, text1
        jal uart_puts
        ld ra, 0(sp)
        addi sp, sp, 8
        ret

        .section .rodata
text1:
        .asciz "Hello RISC-V assembly!\n"
