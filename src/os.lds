OUTPUT_FORMAT("elf64-littleriscv", "elf64-littleriscv", "elf64-littleriscv")
OUTPUT_ARCH(riscv)
ENTRY(_start)
MEMORY
{
        ram (rwx) : ORIGIN = 0x80000000, LENGTH = 64M
}
SECTIONS
{
        . = ORIGIN(ram);
        _text = .;
        .text : {
                *(.text.start)
                *(.text)
        } > ram
        _text_end = .;
        . = ALIGN(16);
        _rodata = .;
        .rodata : {
                *(.rodata)
        } > ram
        _rodata_end = .;
        . = ALIGN(16);
        _data = .;
        .data : {
                *(.data)
        } > ram
        _data_end = .;
        _sdata = .;
        .sdata : {
                PROVIDE(__global_pointer$ = . + 0x800);
                *(.sdata)
        } > ram
        _sdata_end = .;

        . = ALIGN(16);
        _bss = .;
        .bss : {
                *(.bss)
        } > ram
        _bss_end = .;
        . = ALIGN(16);
        _stack = _text + (32*1024*1024);
}
