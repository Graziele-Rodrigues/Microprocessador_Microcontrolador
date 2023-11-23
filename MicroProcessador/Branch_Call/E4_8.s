	EXPORT	__main
	AREA	EXAMPLE4_8, CODE, READONLY	
RAM_ADDR	EQU	0x40000000	; change the address for your Arm
__main
	LDR	R1, =RAM_ADDR	; R1 = RAM address 
AGAIN	
	MOV	R0, #0x55	; R0 = 0x55
	STRB	R0, [R1]	; send it to RAM 
	BL	DELAY  	; call delay (R14 = PC of next instruction)
	MOV	R0, #0xAA	; R0 = 0xAA
	STRB	R0, [R1]	; send it to RAM 
	BL	DELAY  	; call delay 
	B	AGAIN   	; keep doing it

	; --------------------DELAY SUBROUTINE
DELAY	LDR	R3, =5	; R3 =5, modify this value for different delay 
L1	SUBS	R3, R3, #1	; R3 = R3 - 1 
	BNE	L1
	BX	LR		; return to caller
	; --------------------end of DELAY subroutine

	END
