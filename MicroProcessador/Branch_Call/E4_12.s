RCC_APB2ENR EQU 0x40021018	

GPIOA_CRL	EQU 0x40010800
GPIOA_CRH	EQU 0x40010804
GPIOA_IDR	EQU 0x40010808
GPIOA_ODR	EQU 0x4001080C
PORT_ADDR	EQU	0x4001080C	; change the address for your ARM and PORT
	EXPORT __main
	AREA	Example4_12, CODE, READONLY
__main
	LDR	R1,=RCC_APB2ENR
	LDR R0,[R1]
	ORR R0,R0,#0xFC		;enable the clocks for GPIOs
	STR R0,[R1]
	
	LDR R1,=GPIOA_CRL
	LDR R0,=0x33333333
	STR R0,[R1]			;PA0 to PA7 as outputs

	LDR R1,=GPIOA_CRH
	LDR R0,=0x33333333
	STR R0,[R1]			;PA8 to PA15 as outputs

	LDR	R1, =PORT_ADDR	; R1 = port address 
AGAIN	MOV	R0, #0x55	; R0 = 0x55
	STRB	R0, [R1]	; send it to LEDs 
	BL	DELAY		; call delay 
	MOV	R0, #0xAA	; R0 = 0xAA
	STRB	R0, [R1]	; send it to LEDs 
	BL	DELAY		; call delay 
	B	AGAIN		; keep doing it forever 

	; --------------------DELAY SUBROUTINE
DELAY
	MOV	R3, #50  ; R3 = 100, modify this value for different size delay
L1	LDR	R4, =250000	; R4 = 250, 000 (inner loop count) 
L2	SUBS	R4, R4, #1	; 1 clock 
	BNE	L2		; 3 clock 
	SUBS	R3, R3, #1	; R3 = R3 - 1 
	BNE	L1
	BX	LR	; return to caller

	END
