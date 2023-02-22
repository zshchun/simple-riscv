OUTPUT_FORMAT("elf64-littleriscv", "elf64-littleriscv", "elf64-littleriscv")
OUTPUT_ARCH(riscv)
ENTRY(_start)
SECTIONS
{
        . = 0x80000000;
        _text = .;
        .text : {
                *(.text)
        }
        _text_end = .;
        . = ALIGN(16);
        _rodata = .;
        .rodata : {
                *(.rodata)
        }
        _rodata_end = .;
        . = ALIGN(16);
        _data = .;
        .data : {
                *(.data)
        }
        _data_end = .;
        . = ALIGN(16);
        _bss = .;
        .bss : {
                *(.bss)
        }
        _bss_end = .;
        . = ALIGN(16);
        _stack = _text + (32*1024*1024);
}
