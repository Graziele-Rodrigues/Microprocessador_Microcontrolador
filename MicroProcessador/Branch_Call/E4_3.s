	EXPORT __main 
AREA	EXAMPLE4_3, CODE, READONLY
__main	
	MOV	R0, #0x55		; R0 = 0x55
	MOV	R2, #16		; load 16 into R2 (outer loop count)
L1	LDR	R1, =1000000000	; R1 = 1,000,000,000 (inner loop count) 
L2	EOR	R0, R0, #0xFF	; complement R0 (R0 = R0 Ex-OR 0xFF)
	SUBS	R1, R1, #1		; R1 = R1 – 1, decrement R1 (inner loop) 
	BNE	L2			; repeat it until R1 = 0 
	SUBS	R2, R2, #1		; R2 = R2 – 1, decrement R2 (outer loop) 
	BNE	L1			; repeat it until R2 = 0 
HERE	B	HERE			; stay here
	END
