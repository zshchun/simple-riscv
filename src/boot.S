        .section .text.start
        .global _start
        .extern _bss
        .extern _bss_end
        .extern _stack
_start:
#        la gp, __global_pointer$

        csrr a0, mhartid
        slli a1, a0, 13
        la sp, _stack
        sub sp, sp, a1
        bne a0, zero, 2f

        la a3, _bss
        la a4, _bss_end
        beq a3, a4, 3f
init_bss:
        sb zero, 0(a3)
        addi a3, a3, 1
        bne a3, a4, init_bss

3:
        li t0, 0x200bff8
        li t2, 0x2004000
        ld t1, 0(t0)
        li t3, 10 * 1000 * 1000
        add t1, t1, t3
        sd t1, 0(t2)

        la t0, trap_entry
#        la t0, trap_handler
        csrw mtvec, t0

        li t0, 128
        csrrs zero, mie, t0
        csrrs zero, mstatus, 8
#        csrw mie, t0
#        mret

2:
        jal main
        j .

.align 4
trap_entry:
        addi sp, sp, -(10*8)
        sd  ra, 0*8(sp)
        sd  a0, 1*8(sp)
        sd  a1, 2*8(sp)
        sd  a2, 3*8(sp)
        sd  a3, 4*8(sp)
        sd  a4, 5*8(sp)
        sd  a5, 6*8(sp)
        sd  a6, 7*8(sp)
        sd  a7, 8*8(sp)
#        sd  t0, 9*8(sp)
#        sd  t1, 10*8(sp)
#        sd  t2, 11*8(sp)
#        sd  t3, 12*8(sp)
#        sd  t4, 13*8(sp)
#        sd  t5, 14*8(sp)
#        sd  t6, 15*8(sp)

        jal trap_handler

#         csrr t0, mepc
#         lh t2, 0(t0)
#         li t1, 3
#         and t2, t2, t1
#         beq t2, t1, 1f
#         addi t0, t0, 0x2
#         j 2f
# 1:
#         addi t0, t0, 0x4
# 2:
#         csrw mepc, t0

#        csrr t0, mcause
#        li t1, 0x8000000000000007
#        beq t0, t1, 1f
#        j 2f

1:
        li a0, 0x200bff8
        li a2, 0x2004000
        ld a1, 0(a0)
        li a3, 10 * 1000 * 1000
        add a1, a1, a3
        sd a1, 0(a2)

#        li a0, 3
#        csrwi mstatus.mpp, 3

#        csrr t0, mie
#        li t1, 128
#        or t0, t0, t1
#        csrw mie, t0

#        csrci mstatus, 8

2:
#        ld  t6, 15*8(sp)
#        ld  t5, 14*8(sp)
#        ld  t4, 13*8(sp)
#        ld  t3, 12*8(sp)
#        ld  t2, 11*8(sp)
#        ld  t1, 10*8(sp)
#        ld  t0, 9*8(sp)
        ld  a7, 8*8(sp)
        ld  a6, 7*8(sp)
        ld  a5, 6*8(sp)
        ld  a4, 5*8(sp)
        ld  a3, 4*8(sp)
        ld  a2, 3*8(sp)
        ld  a1, 2*8(sp)
        ld  a0, 1*8(sp)
        ld  ra, 0*8(sp)
        addi sp, sp, (10*8)
        mret
