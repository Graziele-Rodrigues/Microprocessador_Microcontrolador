	EXPORT Reset_Handler
	EXPORT __Vectors
	AREA VECTOR, DATA, READONLY
__Vectors
	DCD	stack_init
	DCD	Reset_Handler

	AREA RESET_PROG, CODE, READONLY
Reset_Handler
	LDR		R0,=__main
	BX		R0
	
	AREA MY_PROG, CODE, READONLY
__main	
	LDR  	R0, =0x123		; R0 = 0x123
	LDR  	R1, =0x455		; R1 = 0x455
	LDR  	R2, =0x6677		; R2 = 0x6677
	PUSH 	{R0}
	PUSH	{R1}
	PUSH 	{R2}
	MOV	R0,#0
	MOV	R1,#0
	MOV	R2,#0
	POP	{R2}
	POP	{R1}
	POP {R0}

H	B	H


	AREA STACK, DATA, READWRITE
	SPACE 0x600
stack_init
	END