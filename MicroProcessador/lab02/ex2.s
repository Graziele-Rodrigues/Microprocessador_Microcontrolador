	EXPORT __main
				
	AREA OUR_PROG, CODE, READONLY
__main	
	LDR 	R0, =A
	LDR 	R1, [R0]
	
	LDR 	R0, =B
	LDR 	R2, [R0]
	
	LDR 	R0, =C
	LDR 	R3, [R0]
	
	ADDS	R1,R1,R2
	ADDS	R1,R1,R3
	
loop	B   loop

   AREA	OUR_DATA, DATA, READONLY
A  DCD	0x5
B  DCD	0x2
C  DCD	0x3
	
   END
