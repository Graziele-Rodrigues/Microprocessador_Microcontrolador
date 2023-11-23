	; This program fills a block of memory with a fixed value and 
	; then transfers (copies) the block to new area of memory
RAM1_ADDR	EQU	0x40000000	; Change the address for your Arm
RAM2_ADDR	EQU	0x40000100	; Change the address for your Arm
	EXPORT __main
	AREA	PROGRAM4_3, CODE, READONLY
__main	
	BL	FILL			; call block fill subroutine
	BL	COPY			; call block transfer subroutine
HERE	B	HERE			; Brach here	
	; ----------------BLOCK FILL SUBROUTINE
FILL	LDR  	R1, =RAM1_ADDR	; R1 = RAM Address pointer
	MOV	R0, #10	 	; counter
	LDR	R2, =0x55555555
L1	STR	R2, [R1]		; send it to RAM
	ADD	R1, R1, #4		; R1 = R1 + 4 to increment pointer
	SUBS	R0, R0, #1		; R0 = R0 - 1 to decrement counter 
	BNE	L1			; keep doing it until R0 is 0
	BX	LR			; return to caller
	; -----------------BLOCK COPY SUBROUTINE
COPY	LDR	R1, =RAM1_ADDR	; R1 = RAM Address pointer (source)
	LDR	R2, =RAM2_ADDR	; R2 = RAM Address pointer (destination)
	MOV	R0, #10		; counter
L2	LDR	R3, [R1]		; get from RAM1
	STR	R3, [R2]		; send it to RAM2
	ADD	R1, R1, #4		; R1 = R1 + 4 to increment pointer for RAM1
	ADD	R2, R2, #4		; R2 = R2 + 4 to increment pointer for RAM2
	SUBS	R0, R0, #1		; R0 = R0 – 1 for decrementing counter 
	BNE	L2			; keep doing it
	BX	LR			; return to caller
	; ----------	
	END				
