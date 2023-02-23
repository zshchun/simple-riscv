OBJCOPY := riscv64-linux-gnu-objcopy
AS := riscv64-linux-gnu-as
CC := riscv64-linux-gnu-gcc
LD := riscv64-linux-gnu-ld
OBJS := boot.o main.o
CFLAGS := -O2

.PHONY: all build test debug FORCE

all: build

test: build
	qemu-system-riscv64 -M virt -smp 1 -m 256M -bios none -kernel os.bin -nographic

build: os.bin

debug: CFLAGS += -g
debug: build
	qemu-system-riscv64 -M virt -smp 1 -m 256M -bios none -kernel os.bin -nographic -S -s

gdb:
	gdb-multiarch -ex 'file os.elf' -ex 'target remote localhost:1234'

os.bin: $(OBJS)
	$(LD) -T os.lds $^ -o os.elf
	$(OBJCOPY) -O binary os.elf $@

%.o: %.c $(FORCE) FORCE
	$(CC) $(CFLAGS) -W -Wall -std=c11 -c -nostartfiles -nostdlib $< -o $@

%.o: %.S $(FORCE) FORCE
	$(AS) $< -o $@

clean:
	rm -f *.o *.bin *.elf

FORCE:
