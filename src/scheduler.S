        .global sched
        .global save_context
        .global restore_context
sched:
        ret
        addi sp, sp, -64
        sd a0, 0(sp)
        sd a1, 8(sp)
        mv a0, sp
        mv a1, ra
        srli a0, a0, 13
        slli a0, a0, 13
;        jal save_context
;        jal restore_context
        addi sp, sp, 64
        ret

save_context:
;        sd  a1, 0(a0)
        sd  sp, 8(a0)
        sd  gp, 16(a0)
        sd  tp, 24(a0)
        sd  t0, 32(a0)
        sd  t1, 40(a0)
        sd  t2, 48(a0)
        sd  fp, 56(a0)
        sd  s1, 64(a0)
        sd  a0, 72(a0)
;        sd  a1, 80(a0)
        sd  a2, 88(a0)
        sd  a3, 96(a0)
        sd  a4, 104(a0)
        sd  a5, 112(a0)
        sd  a6, 120(a0)
        sd  a7, 128(a0)
        sd  s2, 136(a0)
        sd  s3, 144(a0)
        sd  s4, 152(a0)
        sd  s5, 160(a0)
        sd  s6, 168(a0)
        sd  s7, 176(a0)
        sd  s8, 184(a0)
        sd  s9, 192(a0)
        sd s10, 200(a0)
        sd s11, 208(a0)
        sd  t3, 216(a0)
        sd  t4, 224(a0)
        sd  t5, 232(a0)
        sd  t6, 240(a0)
        ret

restore_context:
        addi sp, sp, -64
        ld fp, 0(sp)
        mv fp, sp
        slli fp, fp, 13
        srli fp, fp, 13

        ld  t6, 240(fp)
        ld  t5, 232(fp)
        ld  t4, 224(fp)
        ld  t3, 216(fp)
        ld s11, 208(fp)
        ld s10, 200(fp)
        ld  s9, 192(fp)
        ld  s8, 184(fp)
        ld  s7, 176(fp)
        ld  s6, 168(fp)
        ld  s5, 160(fp)
        ld  s4, 152(fp)
        ld  s3, 144(fp)
        ld  s2, 136(fp)
        ld  a7, 128(fp)
        ld  a6, 120(fp)
        ld  a5, 112(fp)
        ld  a4, 104(fp)
        ld  a3, 96(fp)
        ld  a2, 88(fp)
        ld  a1, 80(fp)
        ld  a0, 72(fp)
        ld  s1, 64(fp)
        ld  fp, 56(fp)
        ld  t2, 48(fp)
        ld  t1, 40(fp)
        ld  t0, 32(fp)
        ld  tp, 24(fp)
        ld  gp, 16(fp)
;        ld  sp, 8(fp)
        ld  ra, 0(fp)

        ret
