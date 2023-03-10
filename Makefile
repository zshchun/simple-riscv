OBJCOPY := riscv64-linux-gnu-objcopy
AS := riscv64-linux-gnu-as
CC := riscv64-linux-gnu-gcc
LD := riscv64-linux-gnu-ld
RUSTC := rustc
OBJS := boot.o uart.o main.o mod.o string.o shell.o timer.o spinlock.o asm.o
CFLAGS += -O2 -W -Wall -std=c11 -c -ffreestanding -nostartfiles -nostdlib
LDFLAGS += --no-warn-rwx-segments
MACHINE := virt
CPUS := 2

.PHONY: all build test debug shell FORCE

all: build
test: build
	qemu-system-riscv64 -M $(MACHINE) -smp $(CPUS) -m 256M -bios none -kernel os.bin -nographic -serial mon:stdio

build: os.bin

debug: CFLAGS += -g
debug: build
	qemu-system-riscv64 -M $(MACHINE) -smp $(CPUS) -m 256M -bios none -kernel os.bin -nographic -serial mon:stdio -S -s

gdb:
	gdb-multiarch -ex 'file os.elf' -ex 'target remote localhost:1234'

dts:
	qemu-system-riscv64 -M $(MACHINE) -M dumpdtb=$(MACHINE).dtb
	dtc -I dtb -O dts -o $(MACHINE).dts $(MACHINE).dtb

os.bin: $(OBJS)
	$(LD) $(LDFLAGS) -T os.lds $^ -o os.elf
	$(OBJCOPY) -O binary os.elf $@

%.o: %.c $(FORCE) FORCE
	$(CC) $(CFLAGS) $< -o $@

%.o: %.rs $(FORCE) FORCE
	$(RUSTC) --target=riscv64gc-unknown-none-elf --emit obj $< -o $@

%.o: %.S $(FORCE) FORCE
	$(AS) $< -o $@

clean:
	rm -f *.o *.bin *.elf

FORCE:
