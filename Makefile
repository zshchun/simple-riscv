OBJCOPY := riscv64-linux-gnu-objcopy
AS := riscv64-linux-gnu-as
CC := riscv64-linux-gnu-gcc
OBJS := boot.o

all: os.bin
	qemu-system-riscv64 -M virt -smp 2 -m 256M -kernel os.bin -nographic -serial mon:stdio

os.bin: $(OBJS)
	$(OBJCOPY) -O binary $^ $@

%.o: %.S
	$(AS) $< -o $@
clean:
	rm *.o *.bin
