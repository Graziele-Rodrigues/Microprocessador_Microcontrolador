RCC_APB2ENR EQU 0x40021018	

GPIOA_CRL	EQU 0x40010800
GPIOA_CRH	EQU 0x40010804
GPIOA_IDR	EQU 0x40010808
GPIOA_ODR	EQU 0x4001080C

DELAY_100MS PROC
    MOV R3, #1000      ; Contador externo para 100ms (1ms * 100)
    MOV R2, #100       ; Contador interno para 1ms

DELAY_LOOP1
    MOV R1, #1000      ; Configurar o contador interno para 1ms

DELAY_LOOP2
    SUBS R1, R1, #1    ; Decrementar contador interno
    BNE DELAY_LOOP2    ; Repetir até que R1 seja zero

    SUBS R3, R3, #1    ; Decrementar contador externo
    BNE DELAY_LOOP1    ; Repetir até que R3 seja zero

    BX LR              ; Retornar da sub-rotina
    ENDP

; Definições de registradores e constantes (como RCC_APB2ENR, GPIOA_CRL, etc.)

; Definições específicas para o LED RGB
LED_R   EQU 0x01
LED_G   EQU 0x02
LED_B   EQU 0x04

; Cores
RED     EQU LED_R
GREEN   EQU LED_G
BLUE    EQU LED_B
CYAN    EQU (LED_G | LED_B)

; Sub-rotina para delay de 100ms
DELAY_100MS PROC
    ; Código da sub-rotina delay aqui
    ; ...
    BX LR ; Retornar da sub-rotina
    ENDP

; Sub-rotina para controlar o LED RGB
CONTROL_RGB_LED PROC
    ; Ligar LED (cor passada como parâmetro)
    ORR R0, R0, R0 ; R0 = R0 OR R0 (cor desejada)
    LDR R1, =GPIOA_ODR
    STR R0, [R1]

    ; Aplicar delay de 100ms
    BL DELAY_100MS

    ; Desligar LED
    BIC R2, R0, R0 ; R2 = R0 AND (NOT R0)
    STR R2, [R1]

    ; Aplicar delay de 100ms
    BL DELAY_100MS

    BX LR ; Retornar da sub-rotina
    ENDP

	EXPORT __main
	AREA MAIN, CODE, READONLY
__main	PROC
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

	
	
MAIN_LOOP
    ; A - Ligar LED RGB com a primeira cor (vermelho) por 100ms
    LDR R0, =RED
    BL CONTROL_RGB_LED

    ; B - Desligar LED RGB por 100ms
    LDR R0, =0 ; Desliga todas as cores
    BL CONTROL_RGB_LED

    ; C - Repetir etapas A e B mais 4 vezes
    MOV R3, #4 ; Contador externo para repetir 4 vezes
REPEAT_LOOP
    ; Sub-rotina para etapas A e B
    LDR R0, =RED
    BL CONTROL_RGB_LED

    LDR R0, =0
    BL CONTROL_RGB_LED

    ; Decrementar contador externo
    SUBS R3, R3, #1
    BNE REPEAT_LOOP

    ; D - Trocar a cor do LED RGB e voltar para a etapa A
    ; ... (código para trocar a cor aqui)

    ; Reiniciar o processo com a cor inicial (vermelho)
    B MAIN_LOOP

    ENDP

END
