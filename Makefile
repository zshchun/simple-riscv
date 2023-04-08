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
C_SRCS := $(wildcard $(SRCDIR)/*.c)
C_OBJS := $(addprefix $(OUT)/,$(notdir $(C_SRCS:%.c=%.o)))
RUST_SRCS := $(wildcard $(SRCDIR)/*.rs)
RUST_OBJS := $(addprefix $(OUT)/,$(notdir $(RUST_SRCS:%.rs=%.o)))
ASM_SRCS := $(wildcard $(SRCDIR)/*.S)
ASM_OBJS := $(addprefix $(OUT)/,$(notdir $(ASM_SRCS:%.S=%.o)))
MACHINE := virt
CPUS := 1

.PHONY: all build test debug shell FORCE

all: build
test: build
	qemu-system-riscv64 -M $(MACHINE) -smp $(CPUS) -m 256M -bios none -kernel $(OUT)/os.bin -nographic -serial mon:stdio

build: $(OUT)/os.bin

debug: CFLAGS += -g
debug: build
	qemu-system-riscv64 -M $(MACHINE) -smp $(CPUS) -m 256M -bios none -kernel $(OUT)/os.bin -nographic -serial mon:stdio -S -s

gdb:
	gdb-multiarch -ex "file $(OUT)/os.elf" -ex 'target remote localhost:1234'

dts:
	qemu-system-riscv64 -M $(MACHINE) -M dumpdtb=$(MACHINE).dtb
	dtc -I dtb -O dts -o $(MACHINE).dts $(MACHINE).dtb

$(OUT)/os.bin: $(C_OBJS) $(RUST_OBJS) $(ASM_OBJS)
	echo $^
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
