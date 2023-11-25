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
	ORR R0,R0,#0xFC		; enable the clocks for GPIOs
	STR R0,[R1]
	
	LDR R1,=GPIOB_CRL
	LDR R0,=0x33333333
	STR R0,[R1]			; PB0 to PB7 as outputs

	LDR R1,=GPIOB_CRH
	LDR R0,=0x33333333
	STR R0,[R1]			; PB8 to PB15 as outputs

	LDR R1,=GPIOA_CRL
	LDR R0,=0x88888888
	STR R0,[R1]			; PA0 to PA7 as inputs

	LDR R1,=GPIOA_CRH
	LDR R0,=0x88888888
	STR R0,[R1]			; PA8 to PA15 as inputs
	
	LDR R1,=GPIOA_ODR
	LDR R0,=0x0000
	STR R0,[R1]			; PA0 to PA15 pull-down
	
	MOV R6, #0           ; R6 = valor do LED (inicialmente desligado)
	
LOOP
	; LEITURA DAS CHAVES
	LDR	R10,=GPIOA_IDR
	LDR	R0,[R10]		; R0 = value of GPIOA_IDR
	
	; CHAVES
	; R1 = SW1
	AND R1,R0,#0x01
	; R2 = SW2
	LSR R0,R0,#0x01		; Logical Shift Right
	AND R2,R0,#0x01
	
	; Inicio do algoritmo de controle
	CMP R1, #1           ; Verifica se SW1 está pressionado
	BEQ INCREMENTA
	
	CMP R2, #1           ; Verifica se SW2 está pressionado
	BEQ DECREMENTA
	
	B NAO_PRESSIONADO
	
INCREMENTA
	ADD R6, R6, #1       ; Incrementa valor do LED
	CMP R6, #8           ; Limite superior para o LED (pode ser ajustado)
	BGT LIMITE_SUPERIOR
	
	B NAO_PRESSIONADO
	
DECREMENTA
	SUB R6, R6, #1       ; Decrementa valor do LED
	CMP R6, #0          ; Limite inferior para o LED (pode ser ajustado)
	BLT LIMITE_INFERIOR
	
	B NAO_PRESSIONADO
	
LIMITE_SUPERIOR
	MOV R6, #7           ; Limite superior para o LED
	B NAO_PRESSIONADO
	
LIMITE_INFERIOR
	MOV R6, #0           ; Limite inferior para o LED
	B NAO_PRESSIONADO
	
NAO_PRESSIONADO
	; Fim do algoritmo de controle

	; LED RGB
	MOV R12, R6;
	LSL R12,R12,#5
	
	; ATUALIZA LED RGB
	LDR R10,=GPIOB_ODR
	STR R12,[R10]       ; GPIOB_ODR = R12
	
	; Delay 
	MOV R5, #0x1000000
	B DELAY_LOOP
	
	
DELAY_LOOP
    SUBS R5, R5, #1        ;Subtrai R5 - 1 e atualiza as flags
    BNE DELAY_LOOP         ; Pula se o resultado não for zero
    B LOOP 
			
	END
