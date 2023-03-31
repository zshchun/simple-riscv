        .global sched
        .global save_context
        .global restore_context
sched:
        jal save_context
        jal restore_context
        ret

save_context:
        addi sp, sp, -64
        sd fp, 0(sp)
        mv fp, sp
        srli fp, fp, 13
        slli fp, fp, 13
        sd  ra, 0(fp)
        sd  fp, 8(sp)
        sd  gp, 16(fp)
        sd  tp, 24(fp)
        sd  t0, 32(fp)
        sd  t1, 40(fp)
        sd  t2, 48(fp)
        ld  t0, 0(sp)
        sd  t0, 56(fp)
        sd  s1, 64(fp)
        sd  a0, 72(fp)
        sd  a1, 80(fp)
        sd  a2, 88(fp)
        sd  a3, 96(fp)
        sd  a4, 104(fp)
        sd  a5, 112(fp)
        sd  a6, 120(fp)
        sd  a7, 128(fp)
        sd  s2, 136(fp)
        sd  s3, 144(fp)
        sd  s4, 152(fp)
        sd  s5, 160(fp)
        sd  s6, 168(fp)
        sd  s7, 176(fp)
        sd  s8, 184(fp)
        sd  s9, 192(fp)
        sd s10, 200(fp)
        sd s11, 208(fp)
        sd  t3, 216(fp)
        sd  t4, 224(fp)
        sd  t5, 232(fp)
        sd  t6, 240(fp)
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
