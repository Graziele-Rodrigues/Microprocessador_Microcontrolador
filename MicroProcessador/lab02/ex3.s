A  EQU	0x12345678
B  EQU	0x2
C  EQU	0x3
	
IN1	RN	R1
IN2	RN	R2
IN3	RN	R3
OUT	RN	R4
	
	EXPORT __main

	AREA OUR_PROG, CODE, READONLY
__main	

	LDR 	IN1,=A
	MOV		IN2,#B
	MOV 	IN3,#C
	MOV		OUT,#0
	
	ADDS	OUT,OUT,IN1
	ADDS	OUT,OUT,IN2
	ADDS	OUT,OUT,IN3
	
loop	B   loop

	
   END
