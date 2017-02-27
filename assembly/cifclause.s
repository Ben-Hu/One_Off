movia r10, 0x00040000

addi r1, r0, 1
addi r2, r0, 2
addi r3, r0, 3
addi r4, r1, r2
addi r4, r0, r3

IF:
bne r4, r0, IFTRUE
movia r10, 0x0F0F

IFTRUE:
movia r10, 0X0020



