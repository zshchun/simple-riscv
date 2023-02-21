OUTPUT_FORMAT("elf64-littleriscv", "elf64-littleriscv", "elf64-littleriscv")
OUTPUT_ARCH(riscv)
ENTRY(_start)
SECTIONS
{
        . = 0x80000000;
        .text : {
                *(.text)
        }
        .rodata : {
                *(.rodata)
        }
        .data : {
                *(.data)
        }
        .bss : {
                *(.data)
        }
}
