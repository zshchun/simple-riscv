OBJCOPY := riscv64-linux-gnu-objcopy
AS := riscv64-linux-gnu-as
CC := riscv64-linux-gnu-gcc
LD := riscv64-linux-gnu-ld
CFLAGS += -O2 -W -Wall -std=c11 -c -ffreestanding -nostartfiles -nostdlib
LDFLAGS += --no-warn-rwx-segments
RUSTC := rustc
OUT := out
SRCDIR := src
INCDIR := include
SRCS := $(wildcard $(SRCDIR)/*.c $(SRCDIR)/*.rs $(SRCDIR)/*.S)
#OBJS := $(patsubst %.c,%.o,$(patsubst %.c,%.o,$(patsubst %.c,%.o,$(SRCS))))
#OBJS := $(patsubst %.c,%.o,$(SRCS))
OBJS := $(OUT)/boot.o $(OUT)/uart.o $(OUT)/main.o $(OUT)/mod.o $(OUT)/string.o $(OUT)/shell.o $(OUT)/timer.o $(OUT)/spinlock.o $(OUT)/asm.o
MACHINE := virt
CPUS := 2

.PHONY: all build test debug shell FORCE

all: build
test: build
	qemu-system-riscv64 -M $(MACHINE) -smp $(CPUS) -m 256M -bios none -kernel $(OUT)/os.bin -nographic -serial mon:stdio

build: $(OUT)/os.bin

debug: CFLAGS += -g
debug: build
	qemu-system-riscv64 -M $(MACHINE) -smp $(CPUS) -m 256M -bios none -kernel $(OUT)/os.bin -nographic -serial mon:stdio -S -s

gdb:
	gdb-multiarch -ex 'file os.elf' -ex 'target remote localhost:1234'

dts:
	qemu-system-riscv64 -M $(MACHINE) -M dumpdtb=$(MACHINE).dtb
	dtc -I dtb -O dts -o $(MACHINE).dts $(MACHINE).dtb

$(OUT)/os.bin: $(OBJS)
	@mkdir -p $(OUT)
	$(LD) $(LDFLAGS) -T $(SRCDIR)/os.lds $^ -o $(OUT)/os.elf
	$(OBJCOPY) -O binary $(OUT)/os.elf $@

$(OUT)/%.o: $(SRCDIR)/%.c $(FORCE) FORCE
	@mkdir -p $(OUT)
	$(CC) -I$(INCDIR) $(CFLAGS) $< -o $@

$(OUT)/%.o: $(SRCDIR)/%.rs $(FORCE) FORCE
	@mkdir -p $(OUT)
	$(RUSTC) --target=riscv64gc-unknown-none-elf --emit obj $< -o $@

$(OUT)/%.o: $(SRCDIR)/%.S $(FORCE) FORCE
	@mkdir -p $(OUT)
	$(AS) $< -o $@

clean:
	rm -f $(OUT)/*.o $(OUT)/*.bin $(OUT)/*.elf

FORCE:
