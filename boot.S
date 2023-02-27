        .section .text
        .global _start
        .extern _bss
        .extern _bss_end
        .extern _stack
_start:
        csrr a0, mhartid
        slli a1, a0, 13
        la sp, _stack
        sub sp, sp, a1
        bne a0, zero, 3f

        la a3, _bss
        la a4, _bss_end
        beq a3, a4, 3f
init_bss:
        sb zero, 0(a3)
        addi a3, a3, 1
        bne a3, a4, init_bss
3:
        jal main
        j .
