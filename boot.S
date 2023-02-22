        .section .text
        .global _start
        .extern _bss
        .extern _bss_end
_start:
        li sp, 0x82000000
        la a3, _bss
        la a4, _bss_end
        move a0, zero
1:
        sb a0, 0(a3)
        addi a3, a3, 1
        bne a3, a4, 1b
        jal main
        j .
