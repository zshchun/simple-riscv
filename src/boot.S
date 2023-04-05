        .section .text.start
        .global _start
        .extern _bss
        .extern _bss_end
        .extern _stack
_start:
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
        la t0, trap_entry
        csrw mtvec, t0
        lla t0, 2f
        csrw mepc, t0
        mret

2:
        jal main
        j .

.align 4
trap_entry:
        mret
        addi sp, sp, -256
        sd  t0, 32(sp)
        sd  t1, 40(sp)
        sd  t2, 48(sp)
;        sd  fp, 56(sp)
        sd  s1, 64(sp)
        sd  a0, 72(sp)
        sd  a1, 80(sp)
        sd  a2, 88(sp)
        sd  a3, 96(sp)
        sd  a4, 104(sp)
        sd  a5, 112(sp)
        sd  a6, 120(sp)
        sd  a7, 128(sp)
        sd  s2, 136(sp)
        sd  s3, 144(sp)
        sd  s4, 152(sp)
        sd  s5, 160(sp)
        sd  s6, 168(sp)
        sd  s7, 176(sp)
        sd  s8, 184(sp)
        sd  s9, 192(sp)
        sd s10, 200(sp)
        sd s11, 208(sp)
        sd  t3, 216(sp)
        sd  t4, 224(sp)
        sd  t5, 232(sp)
        sd  t6, 240(sp)

;        jal trap_handler 

        csrr t0, mie
        li t1, 128
        and t0, t0, a0
        csrw mie, t0

        csrr t0, mepc
        addi t0, t0, 0x4
        csrw mepc, t0

li t0, 0x00001800
  csrs mstatus, t0


        ld  t6, 240(sp)
        ld  t5, 232(sp)
        ld  t4, 224(sp)
        ld  t3, 216(sp)
        ld s11, 208(sp)
        ld s10, 200(sp)
        ld  s9, 192(sp)
        ld  s8, 184(sp)
        ld  s7, 176(sp)
        ld  s6, 168(sp)
        ld  s5, 160(sp)
        ld  s4, 152(sp)
        ld  s3, 144(sp)
        ld  s2, 136(sp)
        ld  a7, 128(sp)
        ld  a6, 120(sp)
        ld  a5, 112(sp)
        ld  a4, 104(sp)
        ld  a3, 96(sp)
        ld  a2, 88(sp)
        ld  a1, 80(sp)
        ld  a0, 72(sp)
        ld  s1, 64(sp)
;        ld  fp, 56(sp)
        ld  t2, 48(sp)
        ld  t1, 40(sp)
        ld  t0, 32(sp)
;        ld  sp, 8(sp)
        addi sp, sp, 256
        mret
