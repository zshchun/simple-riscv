OBJCOPY := riscv64-linux-gnu-objcopy
AS := riscv64-linux-gnu-as
CC := riscv64-linux-gnu-gcc
LD := riscv64-linux-gnu-ld
OBJS := boot.o main.o

all: os.bin
	qemu-system-riscv64 -M virt -smp 1 -m 256M -bios none -kernel os.bin -nographic

os.bin: $(OBJS)
	$(LD) -T os.lds $^ -o os.elf
	$(OBJCOPY) -O binary os.elf $@

%.o: %.c
	$(CC) -O2 -W -Wall -std=c11 -c -nostartfiles -nostdlib $< -o $@

%.o: %.S
	$(AS) $< -o $@

clean:
	rm -f *.o *.bin *.elf
