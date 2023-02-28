A toy OS for the RISC-V
======================
# Prerequisites
## Debian/Ubuntu
```
apt install curl build-essential qemu-system-misc gcc-riscv64-linux-gnu binutils-riscv64-linux-gnu gdb-multiarch
```

## Install rust/[rustup](https://github.com/rust-lang/rustup)
```
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
rustup target add riscv64gc-unknown-none-elf
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

Quit: Ctrl-a x
