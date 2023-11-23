		EXPORT __main
		AREA	EXAMPLE4_1, CODE, READONLY
__main	LDR 	R2, =1000	; R2 = 1000 (decimal) for counter 
		MOV 	R0, #0 	; R0 = 0 (sum)
AGAIN 	ADD 	R0, R0, #9	; R0 = R0 + 9 (add 09 to R1, R1 = sum)
		SUBS	R2, R2, #1	; Decrement counter and set the flags. 
		BNE 	AGAIN		; repeat until COUNT = 0 (when Z = 1)
		MOV 	R4, R0	; store the sum in R4
HERE	B		HERE		; stay here
    	END
