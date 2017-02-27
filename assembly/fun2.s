.include "nios_macros.s"
#.equ LEDR, 0x10000000  #this refers to all LEDRs
.global main

main:
	movia r8, 0x10000000  
	movi r9, 1 #assign to leds
	movi r14, 0 #backwards bit
	movi r15, 0 #off on switch	
	movi r19, 10 #random
	movi r1, 1
	movi r2, 2
	movi r3, 3
	movi r4, 4
	movi r5, 5
	movi r6, 6
	movi r7, 7
	movi r8, 8
	movi r11, 9
	
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
	ble r13, r1, setled1
	ble r13, r2, setled2
	ble r13, r3, setled3
	ble r13, r4, setled4
	ble r13, r5, setled5
	ble r13, r6, setled6
	ble r13, r7, setled7
	ble r13, r8, setled8
	ble r13, r11, setled9
	
	
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

setled1:
	movi r9, 0'b100000000000000001
	stwio r9, 0(r8) #turn on the led
	
setled2:
	movi r9, 0'b010000000000000010
	stwio r9, 0(r8) #turn on the led

setled3:
	movi r9, 0'b001000000000000100
	stwio r9, 0(r8) #turn on the led
	
setled4:
	movi r9, 0'b000100000000001000
	stwio r9, 0(r8) #turn on the led
	
setled5:
	movi r9, 0'b000010000000010000
	stwio r9, 0(r8) #turn on the led

setled6:
	movi r9, 0'b000001000000100000
	stwio r9, 0(r8) #turn on the led

setled7:
	movi r9, 0'b000000100001000000
	stwio r9, 0(r8) #turn on the led

setled8:
	movi r9, 0'b000000010010000000
	stwio r9, 0(r8) #turn on the led

setled9:
	movi r9, 0'b000000001100000000
	stwio r9, 0(r8) #turn on the led
	
.end