RAM_ADDR EQU 0x20000000	

EXPORT __main
AREA	EXAMPLE4_2, CODE, READONLY
__main
	MOV	R2, #25		; counter (25 x 4 = 100 byte block size)
	LDR	R1, =RAM_ADDR	; R1 = RAM Address 
	LDR	R0, =0x55555555	; R0 = 0x55555555

OVER	STR	R0, [R1]		; send it to RAM
	ADD	R1, R1, #4		; R1 = R1 + 4 to increment pointer 
	SUBS	R2, R2, #1		; R2 = R2 – 1 for decrement counter 
	BNE	OVER			; keep doing it
	
HERE	B	HERE
    	END
