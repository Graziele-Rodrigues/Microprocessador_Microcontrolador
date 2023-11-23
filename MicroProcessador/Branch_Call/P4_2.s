	EXPORT __main
	AREA   PROG_4_2, CODE, READONLY 	; Division by subtractions
__main	   
	LDR	R0, =2012	; R0 = 2012 (numerator)
				; it will contain remainder
	MOV	R1, #10	; R1 = 10 (denominator)
	MOV	R2, #0	; R2 = 0 (quotient)
L1	CMP	R0, R1	; Compare R0 with R1 to see if less than 10
	BLO	FINISH	; if R0 < R1 jump to finish
	SUB	R0, R0, R1	; R0 = R0 - R1 (division by subtraction)
	ADD	R2, R2, #1	; R2 = R2 + 1 (quotient is incremented) 
	B	L1		; go to L1 (B is discussed in the next section)
FINISH B	FINISH
