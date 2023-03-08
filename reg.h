#ifndef REG_T_
#define REG_T_

#define REG(base, addr, type) ((volatile type*)(base+addr))

#define WRITE_REG(base, addr, val, type) (volatile type)(*REG(base, addr, type) = val)
#define READ_REG(base, addr, type) (volatile type)(*REG(base, addr, type))
#endif
