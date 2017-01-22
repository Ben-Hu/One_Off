.include "nios_macros.s"

.equ ADDR_REDLEDS, 0x10000000

.global main

main:

  movia sp, 0x007FFFFC	
  movia r13,ADDR_REDLEDS 
  movi  r16,0            
  
LOOP:
  addi r13, r13, 1
  stwio r15,0(r13)  /* Write to Red LEDs */
  
DELAY:
subi r9, r9, 1
bne r9, r0, DELAY
stwio r15, 0(r0)
br LOOP