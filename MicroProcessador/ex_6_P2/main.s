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
		
	AREA QUESTAO, CODE, READONLY
__main   PROC
	     LDR	R0, =VECT_X
	     LDR	R4, =VECT_Y
	     MOV R3, #0X03

LOOP	LDRB R1,[R0]	
		BL CALC
		STRB R1, [R4]
		ADD R0, R0, #0X01
		ADD R4, R4, #0X01
		SUBS R3, R3, #0X01
		BNE LOOP

H 		B 			H
		ENDP

CALC 	PROC
		ADDS R1,R2,R3
		BX LR
    	ENDP

	  AREA QUESTAO2_DATAR, DATA, READONLY
VECT_X	DCB 0X0A,0X05,0X02

	  AREA QUESTAO2_DATAW, DATA, READWRITE
VECT_Y	SPACE 4
	    
		END
