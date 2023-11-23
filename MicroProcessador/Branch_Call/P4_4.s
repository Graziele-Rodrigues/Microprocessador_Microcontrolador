	EXPORT __main
	AREA	MY_CODE, CODE, READONLY
__main
	BL	FUNC1
HERE	B	HERE

	; subroutine FUNC1
FUNC1
	PUSH	{LR}	;store the LR on the stack
	BL	FUNC2		;the func. call changes the LR
	POP		{LR}	;restore the LR from the stack
	BX	LR

	; subroutine FUNC2
FUNC2
	;do something
	BX LR	; return 	
	END
	