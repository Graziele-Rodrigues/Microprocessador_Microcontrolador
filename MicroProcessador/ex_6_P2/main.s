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
		
	EXPORT __main
	AREA	MY_CODE, CODE, READONLY
__main  PROC
		LDR R0, =DATA
		LDRSB R1, [R0]
		ADD R0, R0, #0x01
		LDRB R2, [R0]
		PUSH{R0-R2}
		MOV R0, 0x01
		MOV R1, #0x02
		MOV R2, #0x03
		POP{R0-R2}
	
HERE	B	HERE
	    ENDP
			
	AREA MY_CODE_R, DATA, READONLY
DATA DCB 0xFE, 0X0A
	END
	
	