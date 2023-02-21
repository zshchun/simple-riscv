        .global _start
_start:
        li sp, 0x82000000
        jal main
        j .
