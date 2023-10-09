	EXPORT Reset_Handler
	EXPORT __Vectors
		
	;the vector table 
	;(The followings will be stored in memory loc. starting from 0)
	AREA RESET, DATA, READONLY
__Vectors
	DCD	stack_init		;init locations 0 to 3 with stack space
	DCD	Reset_Handler	;store Reset_Handler into loc. 4 to 7

	; reserving 400 bytes of RAM for stack
	AREA STACK, DATA, READWRITE
	SPACE 400
stack_init

	AREA MY_STARTUP, CODE, READONLY
Reset_Handler	PROC
	LDR	R5,=__main	
	BX	R5		; go to __main
	ENDP

	AREA MY_PROG, CODE, READONLY
__main	PROC
	LDR  R0,=0x33322292
	LDR  R1,=0x55566623
	LDR  R2,=0x9998884B
	LDR  R3,=0xFF
	LDR  R4,=0xDDDEEE01
	ADD  R5, R0, R1
	ADD  R5, R5, R2
	ADD  R5, R5, R3
	ADD  R5, R5, R4

HERE B HERE
	ENDP

	END
