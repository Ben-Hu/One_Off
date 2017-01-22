.include "nios_macros.s"
.equ LEDR, 0x1000 0000  #this refers to all LEDRs
.global main

main:
	movia r8, LEDR
	movi r9, 1
	movi r15, 0 #off on bit	
	stwio r9, 0(r8)   #led1 on,  stwio by passes buffer 
	moviu r10, 1000000 #delay countdown 
	
loop:
	subi r10, r10 1
	bne r10, r0, loop #wait
	bne r15, r0, switchon
	movi r9, 0 #turn off the led
	stwio r9, 0(r8) # first bit becomes 0 side note: if you want to turn on led 2 then do r9 2(r8)
	stwio r9, 1(r8)
	stwio r9, 2(r8)
	stwio r9, 3(r8)
	moviu r10, 1000000
	movi r15, 1 #turned off this delay, after next delay will branch to switch on and turn the led on
	br loop

switchon:
	movi r9, 1
	stwio r9, 0(r8) #turn on the led 
	stwio r9, 1(r8)
	stwio r9, 2(r8)
	stwio r9, 3(r8)
	moviu r10, 1000000 #reset delay counter
	movi r15, 0 #turned on led this delay, next will turn the led off
	br loop #branch back to the loop
	
.end