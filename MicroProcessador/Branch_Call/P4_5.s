	EXPORT __main
	AREA	MY_CODE, CODE, READONLY
__main
	BL	DELAY
HERE	B	HERE

DELAY
	PUSH	{R0}		;store R0 onto the stack
	LDR	R0,=120000
D_1	SUBS	R0,R0,#1
	BNE	D_1
	POP		{R0}		;restore R0
	END
