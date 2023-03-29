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
        sd ra, 0(sp)
        sd sp, 8(sp)
        sd gp, 16(sp)
        sd tp, 24(sp)
        sd t0, 32(sp)
        sd t1, 16(sp)
        sd t2, 16(sp)
        sd fp, 16(sp)
        sd s1, 16(sp)
        sd a0, 16(sp)
        sd a1, 16(sp)
        sd a2, 16(sp)
        sd a3, 16(sp)
        sd a4, 16(sp)
        sd a5, 16(sp)
        sd a6, 16(sp)
        sd a7, 16(sp)
        sd s2, 16(sp)
        sd s3, 16(sp)
        sd s4, 16(sp)
        sd s5, 16(sp)
        sd s6, 16(sp)
        sd s7, 16(sp)
        sd s8, 16(sp)
        sd s9, 16(sp)
        sd s10, 16(sp)
        sd s11, 16(sp)
        sd t3, 16(sp)
        sd t4, 16(sp)
        sd t5, 16(sp)
        sd t6, 16(sp)
        ret

restore_context:
