	EXPORT __main
AREA     EXAMPLE3_8, CODE, READONLY 
__main
	LDR 	R0, =0xF62562FA	; R0 = 0xF62562FA, 
					; notice the syntax for LDR
	LDR 	R1, =0xF412963B	; R1 = 0xF412963B	
	MOV 	R2, #0x21		; R2 = 0x21
	MOV 	R3, #0x35		; R3 = 0x35	
	SUBS	R5, R1, R0		; R5 = R1 – R0
					;    = 0xF412963B – 0xF62562FA, and C = 0
	SBC	R6, R3, R2		; R6 = R3 – R2 – 1 + C 
					;    = 0x35 – 0x21 – 1 + 0 = 0x13
HERE	B	HERE


	END
