RCC_APB2ENR EQU 0x40021018	

GPIOA_CRL	EQU 0x40010800
GPIOA_CRH	EQU 0x40010804
GPIOA_IDR	EQU 0x40010808
GPIOA_ODR	EQU 0x4001080C

GPIOB_CRL	EQU 0x40010C00
GPIOB_CRH	EQU 0x40010C04
GPIOB_IDR	EQU 0x40010C08
GPIOB_ODR	EQU 0x40010C0C

	EXPORT __main
	AREA MAIN, CODE, READONLY
__main
	LDR	R1,=RCC_APB2ENR
	LDR R0,[R1]
	ORR R0,R0,#0xFC		;enable the clocks for GPIOs
	STR R0,[R1]
	
	LDR R1,=GPIOB_CRL
	LDR R0,=0x33333333
	STR R0,[R1]			;PB0 to PB7 as outputs

	LDR R1,=GPIOB_CRH
	LDR R0,=0x33333333
	STR R0,[R1]			;PB8 to PB15 as outputs

	LDR R1,=GPIOA_CRL
	LDR R0,=0x88888888
	STR R0,[R1]			;PA0 to PA7 as inputs

	LDR R1,=GPIOA_CRH
	LDR R0,=0x88888888
	STR R0,[R1]			;PA8 to PA15 as inputs
	
	LDR R1,=GPIOA_ODR
	LDR R0,=0x0000
	STR R0,[R1]			;PA0 to PA15 pull-down
	
	
LOOP
	; LEITURA DOS SENSORES
	LDR	R10,=GPIOA_IDR
	LDR	R0,[R10]		;R0 = value of GPIOA_IDR
	
	;SENSORES
	; R1 = S1
	AND R1,R0,#0x01
	; R2 = S2
	LSR R0,R0,#0x01		;Logical Shift Right
	AND R2,R0,#0x01
	; R3 = S3
	LSR R0,R0,#0x01		;Logical Shift Right
	AND R3,R0,#0x01
	; R4 = S4
	LSR R0,R0,#0x01		;Logical Shift Right
	AND R4,R0,#0x01

	; Inicio do algoritmo de controle
	B CONTROLE_BOMBA1
	
CONTROLE_BOMBA1
	AND R5, R1, R2 ;quando S1 e S2 pressionados R5 é 1
	CMP R5, #1     ;se R5 é 1 tanque inferior está cheio
	BEQ DESLIGA_BOMBA1 ;desliga_bomba1
	B LIGA_BOMBA1   ;liga bomba_1
	
DESLIGA_BOMBA1 
	MOV R11, #0
	MOV R9, R11
	B BOMBA2
	
LIGA_BOMBA1
	MOV R11, #1
	MOV R9, R11
	B CONTROLE_BOMBA1

BOMBA2
	;INICIO B2
	AND R5, R3, R4     ;Se S3 ou S4 pressionado, nível do tanque superior alto
    CMP R5, #1         ;Nível do tanque superior intermediário ou máximo
	BEQ DESLIGA_BOMBA2   ;Ligue a bomba 2
	CMP R3, #0           ;Se S3 nao pressionado, tanque inferior baixo
	CMP R9, #0          ;E tanque inferior nivel intermediario
	BEQ LIGA_BOMBA2     ;Ligue a bomba 2
    B BOMBA2   
	
LIGA_BOMBA2
	MOV R12, #1
	B BOMBA2
	
DESLIGA_BOMBA2
	MOV R12, #0
	B FIM
	
FIM
	
	; Fim do algoritmo de controle

	; BOMBAS
	; R11 = BOMBA 1
	;MOV R11,R1	; Bomba 1 = S1
	; R12 = BOMBA 2
	;MOV R12,R2	; Bomba 2 = S2
	; CONCATENA RESPOSTA EM R12
	LSL R12,R12,#0x01
	ORR	R12,R12,R11
	
	; LIGA/DESLIGA BOMBAS
	LDR R10,=GPIOB_ODR
	STR R12,[R10]			;GPIOB_ODR = R12
	B LOOP
			
	END
