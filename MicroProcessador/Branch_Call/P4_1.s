
	; searching for highest value in a list
COUNT		RN	R0		; COUNT is the new name of R0
MAX		RN	R1		; MAX is the new name of R1 
					; (MAX has the highest value)
POINTER	RN	R2		; POINTER is the new name of R2
NEXT		RN	R3		; NEXT is the new name of R3

   		AREA   PROG_4_1D, DATA, READONLY
MYDATA	DCD	69, 87, 96, 45, 75

		EXPORT __main
    		AREA   PROG_4_1, CODE, READONLY
__main
		MOV	COUNT, #5		; COUNT = 5
		MOV	MAX, #0		; MAX = 0
		LDR	POINTER, =MYDATA	; POINTER has the address of first data
AGAIN		LDR	NEXT, [POINTER]	; load NEXT with contents at address
						; in POINTER
		CMP	MAX, NEXT		; compare MAX and NEXT
		BHS	CTNU			; if MAX > NEXT branch to CTNU
		MOV	MAX, NEXT		; MAX = NEXT
CTNU		ADD	POINTER, POINTER, #4	; increment POINTER for next word
		SUBS	COUNT, COUNT, #1	; decrement counter		
		BNE	AGAIN			; branch AGAIN if counter is not zero

HERE		B	HERE
		END
