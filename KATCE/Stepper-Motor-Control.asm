	section .text
	

;-----------------------------------------------------------
; Title      :  Stepper Motor Control with input for KATCE based computer.
; Written by :  Kaan Ozcelik
; Date       :  21.4.2016
; Description:  Uses PC keyboard input to control a stepper motor through a serial link.
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
	
	MOVE #5000,D6 ;-- Set the initial delay.
	
	JMP FATHER_LOOP
	
		;------------------------ SUBPROGRAMS ------------------------
ROTATE_L:
	MOVE.B #%1010,PADR
	JSR DELAY
	MOVE.B #%0110,PADR
	JSR DELAY
	MOVE.B #%0101,PADR
	JSR DELAY
	MOVE.B #%1001,PADR
	JSR DELAY
	RTS
	
ROTATE_R:
	MOVE.B #%1001,PADR
	JSR DELAY
	MOVE.B #%0101,PADR
	JSR DELAY
	MOVE.B #%0110,PADR
	JSR DELAY
	MOVE.B #%1010,PADR
	JSR DELAY
	RTS
	
DELAY:
	CMP.L D6,D5
	BEQ.B ENDDELAY
	
	ADD #1,D5
	JMP DELAY
ENDDELAY:
	CLR.L D5
	RTS	
	
	;----------------------------------------------------------------------

	
FATHER_LOOP:
	CLR.L D0
	MOVE.W #$04,-(SP)
	TRAP #4
	
	;-- Register D0 is the flag register for "KEYPRESS", if a key has been pressed it is set.
	CMP.B #1,D0
	BEQ.B KEY_CHECK
	
	JMP IDLE
	
IDLE:
	BTST #2,D2
	BEQ.B HALTED
	
	BTST #0,D2
	BNE.B MOVING_L
	
	BTST #1,D2
	BNE.B MOVING_R
	
	JMP FATHER_LOOP
	

MOVING_L:
	JSR ROTATE_L
	JMP FATHER_LOOP
MOVING_R:
	JSR ROTATE_R
	JMP FATHER_LOOP
HALTED:
	JMP FATHER_LOOP
				
		
KEY_CHECK:
	MOVE.W #$06,-(SP)
	TRAP #4
	
	;-- Set the direction bits.
	
	CMP.B #$34,D0
	BEQ.B LEFT
	
	CMP.B #$36,D0
	BEQ.B RIGHT
	
	;-- ON/OFF Bit set.
	CMP.B #$20,D0
	BEQ.B SWITCH
	
	;-- Speed controls.
	CMP.B #$2B,D0
	BEQ.B SPEED_UP
	
	CMP.B #$2D,D0
	BEQ.B SPEED_DOWN
	
	JMP FATHER_LOOP
	
SPEED_UP:
	SUB #100,D6
	JMP FATHER_LOOP
	
LEFT:
	BSET #0,D2
	BCLR #1,D2
	JMP FATHER_LOOP
RIGHT:
	BSET #1,D2
	BCLR #0,D2
	JMP FATHER_LOOP
SWITCH:
	BCHG #2,D2
	JMP FATHER_LOOP
	
	
ENDPROGRAM:
	
	
	
	RTS
	
	*--- All Constants go here
	*--- Note that KATCE does not operate on C-Type Strings.
	*--- Thus no null terminator is required and the string length must precede the string.
	
	END