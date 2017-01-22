.include "nios_macros.s"
#.equ LEDR, 0x10000000  #this refers to all LEDRs
.global main

main:
	movia r8, 0x10000000  
	movi r9, 1 #assign to leds
	movi r14, 0 #backwards bit
	movi r15, 0 #off on switch	
	movi r12, 0 #off bit
	movi r13, 0 #accumulator
	movi r19, 19 #random
	movi r16, 1 #just here
	stwio r9, 0(r8)   #led1 on,  stwio by passes buffer 
	movui r10, 65535 #delay countdown. imm must be < 65535?
	add r10, r10, r10
	add r10, r10, r10
	add r10, r10, r10
	add r10, r10, r10
	add r10, r10, r10


loop:
	subi r10, r10, 1
	bne r10, r0, loop #wait
	bne r15, r0, switchon
	#movi r9, 0 #turn off the led
	stwio r12, 0(r8) # first bit becomes 0 side note: if you want to turn on led 2 then do r9 2(r8)
	movui r10, 65535
	add r10, r10, r10
	add r10, r10, r10
	add r10, r10, r10
	add r10, r10, r10


	movi r15, 1 #turned off this delay, after next delay will branch to switch on and turn the led on
	br loop

switchon:
	add r9, r9, r9
	addi r13, r13, 1
	bge r13, r19, reset
	stwio r9, 0(r8) #turn on the led
	movui r10, 65535 #reset delay counter
	add r10, r10, r10
	add r10, r10, r10
	add r10, r10, r10
	add r10, r10, r10
	add r10, r10, r10


	movi r15, 0 #turned on led this delay, next will turn the led off
	br loop #branch back to the loop

reset:
	movi r9, 1
	movi r13, 0
	br switchon
	

	


	
.end