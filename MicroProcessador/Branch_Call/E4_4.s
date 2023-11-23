	EXPORT __main 
AREA	EXAMPLE4_4, CODE, READONLY
__main	
	MOV   R1, #0		; clear high word (R1 = 0)
	MOV	R0, #0		; clear low word (R0 = 0)
	LDR	R2, =0x99999999	; R2 = 0x99999999	
	ADDS	R0, R0, R2		; R0 = R0 + R2 and set the flags
	BCC	L1			; if C = 0, jump to L1 and add next number
	ADDS	R1, R1, #1		; ELSE, increment (R1 = R1 + 1) 
L1	ADDS	R0, R0, R2		; R0 = R0 + R2 and set the flags
	BCC	L2			; if C = 0, add next number
	ADDS	R1, R1, #1		; if C = 1, increment 
L2	ADDS	R0, R2		; R0 = R0 + R2 and set the flags
	BCC	L3			; if C = 0, add next number
	ADDS	R1, R1, #1		; C = 1, increment 
L3	ADDS	R0, R2		; R0 = R0 + R2 and set the flags
	BCC	L4			; if C = 0, add next number
	ADDS	R1, R1, #1		; if C = 1, and set the flags
L4

HERE	B	HERE			; stay here
	END
