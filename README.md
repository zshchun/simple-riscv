A toy OS for the RISC-V
======================
# Prerequisites
## Debian/Ubuntu
```
apt install build-essential qemu-system-misc gcc-riscv64-linux-gnu binutils-riscv64-linux-gnu gdb-multiarch
```

# Build
```
make
```

# Run with QEMU
```
make test
```

# Debug with QEMU
Process 1
```
make debug
```
```
make gdb
```
