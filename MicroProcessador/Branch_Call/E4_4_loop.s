	EXPORT __main 
AREA	EXAMPLE4_4, CODE, READONLY
__main	
	MOV   R1, #0		; clear high word (R1 = 0)
	MOV	R0, #0		; clear low word (R0 = 0)
	LDR	R2, =0x99999999	; R2 = 0x99999999
	MOV	R3, #10		; counter
L1	ADDS	R0, R2		; R0 = R0 + R2 and set the flags
	BCC	NEXT			; if C = 0, add next number
	ADD	R1, R1, #1		; if C = 1, increment the upper word 
NEXT	SUBS	R3, R3, #1		; R3 = R3 - 1 and set the flags 
					; (Decrement counter)
	BNE	L1			; next round if Z = 0
HERE	B	HERE			; stay here
	END
