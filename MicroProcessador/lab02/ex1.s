	EXPORT __main
				
	AREA OUR_PROG, CODE, READONLY
__main	
	LDR 	R0, =A
	MOV 	R1, #5
	STR 	R1, [R0]
	MOV 	R1, #0xA
	STR 	R1, [R0]

	LDR 	R0, =B
	MOV 	R1, #4
	STR 	R1, [R0]
	MOV 	R1, #0x8
	STR 	R1, [R0]
	
	LDR 	R0, =A
	LDR 	R1, [R0]

	LDR 	R0, =B
	LDR 	R2, [R0]

	ADD 	R3, R1, R2
	LDR 	R0, =C
	STR	R3, [R0]
loop	B   loop

   AREA	OUR_DATA, DATA, READWRITE
A  SPACE	4
B  SPACE	4
C  SPACE	4
	
   END
