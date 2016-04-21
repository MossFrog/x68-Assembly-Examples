	section .text
	

;-----------------------------------------------------------
; Title      :  Stepper Motor Tester for the KATCE Microcomputer
; Written by :  Kaan Ozcelik
; Date       :  7.4.2016
; Description:  Uses the output ports on the Motorola 68000 to rotate a stepper motor clockwise.
;-----------------------------------------------------------






main:

CR EQU $0D 
LF EQU $0A
SPACE EQU $20

PGCR 	EQU $400001 	;Port General Control Register
PADDR EQU $400005 	;Port A Data Direction Register
PACR 	EQU $40000D 	;Port A Control Register
PADR 	EQU $400011 	;Port A Data Register


INIT: 	
	MOVE.B #$00,PGCR 		; MODE 0
	MOVE.B #$80,PACR 		; SUBMODE 1X 
	MOVE.B #%11111111,PADDR 	;all pins of PORT A are outputs
	

	;--- D2 is the designated register for monitoring the stepper motor.
	CLR.L D2
	CLR.L D1
	
	;-- Registers D5 and D6 are used for speed control and delay timing.
	CLR.L D5
	CLR.L D6
	
	MOVE #4000,D6
	
	JMP ROTATELEFT
	
	JSR ROTATELEFT
	JMP ENDPROGRAM
	
ROTATELEFT:
	MOVE.B #%1010,PADR
	JSR DELAY
	MOVE.B #%0110,PADR
	JSR DELAY
	MOVE.B #%0101,PADR
	JSR DELAY
	MOVE.B #%1001,PADR
	JSR DELAY
	JMP ROTATELEFT

	
DELAY:
	CMP.L D6,D5
	BEQ.B ENDDELAY
	
	ADD #1,D5
	JMP DELAY
ENDDELAY:
	CLR.L D5
	RTS
	
ENDPROGRAM:
	
	
	
	RTS
	
	*--- All Constants go here
	*--- Note that KATCE does not operate on C-Type Strings.
	*--- Thus no null terminator is required and the string length must precede the string.
	
	END