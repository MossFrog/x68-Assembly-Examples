	section .text
	
	;-----------------------------------------------------------
	; Title      : Single Character Parity Bit
	; Written by : Kaan Ozcelik
	; Date       : 21.3.2016 (Converted for KATCE on the 31st)
	; Description: Utilizes 8-Bit ascii and sets the leftmost bit to 1 or 0 according to the number of 1's.
	;-----------------------------------------------------------
CR EQU $0D 
LF EQU $0A
SPACE EQU $20

main:
	;-- Register for storing the current index -> D5
    	;-- The program alternates the parity bit (at index 7) whenever it encounters a "1" 
    	
	LEA 	PROMPT,A1 ;-- Display the prompt string
	MOVE.W	#$0D,-(SP)
	TRAP	#4
	
	MOVE.W	#$06,-(SP) ;-- Get a single ASCII character and store in D0.B
	TRAP	#4
	
	MOVE.W  D0,D1 ;-- Move the input character to register D1
	
	movem.l	d0-d1,-(sp)	
	LEA 	NULLSTR,A1 ;-- Skip a line.
	MOVE.W	#$0D,-(SP)
	TRAP	#4
	movem.l	(sp)+,d0-d1
	
	;CLR.L D5 ;-- Clear the registers.
    	;CLR.L D6
        
TSTLOOP: ;-- Loop for checking each bit until the leftmost
   	CMP.B #7,D5 ;-- Check if the last bit has been compared, else continue
    	BEQ.B END

	BTST D5,D1 ;-- Test the bit at index D5
	BEQ.B ZERO ;-- Branch to ZERO if '1'
	;BNE.B ONE ;-- Branch to ONE if '0'

ONE:
    	ADD.B #1,D5 ;-- Add one to the index
    	BCHG #7,D1 ;-- Invert the bit at index 7 (leftmost)
    	JMP TSTLOOP ;-- Return to the testloop
    
ZERO:
    	ADD.B #1,D5 ;-- Add one to the index
    	JMP TSTLOOP ;-- Return to the testloop
      
PRINT: ;-- Printing result methods
    	BTST D5,D2
    	BEQ.B PRINTSUB0
    	
    	;BNE.B PRINTSUB1
    
    
PRINTSUB1:  ;-- If character "1"
    	MOVE.B #$31,D0
    	MOVE.W #$09,-(SP)
    	TRAP #4
    	
    	SUB.B #1,D5
    
	CMP.L #$FF,D5
	BEQ.B ENDPRINT 
	JMP PRINT
    

PRINTSUB0:  ;-- If character "0"

    	MOVE.B #$30,D0
    	MOVE.W #$09,-(SP)
    	TRAP #4
    	
    	SUB.B #1,D5
    
    	CMP.L #$FF,D5
    	BEQ.B ENDPRINT
    	JMP PRINT
    
ENDPRINT:
    	RTS
    
END:
    	;-- Print the new bit-string with the altered parity bit --;
    	movem.l	d0-d1,-(sp)	
	LEA 	NULLSTR,A1 ;-- Skip a line.
	MOVE.W	#$0D,-(SP)
	TRAP	#4
	movem.l	(sp)+,d0-d1
    
    	MOVE.L D1,D2 ;-- Move the contents of D1 into D2 for preservation.
    	JSR PRINT
    
    	LEA NULLSTR,A1 ;-- Skip a line.
    	MOVE.W #$0D,-(SP)
    	TRAP #4
    
    	LEA END_MESSAGE,A1 ;-- Display the END of program message
    	MOVE.W #$0D,-(SP)
    	TRAP #4
        
	RTS
	
;-- Definitions --;

NULLSTR: DC.B 2,CR,LF

PROMPT: DC.B 4,"--> "

END_MESSAGE: DC.B 11,"--- END ---"
		
	END