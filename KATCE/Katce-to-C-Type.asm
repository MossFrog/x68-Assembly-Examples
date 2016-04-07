	section .text
	

;-----------------------------------------------------------
; Title      :  KATCE to C-Type + NULL to SPACE
; Written by :  Kaan Ozcelik
; Date       :  7.4.2016
; Description:  Partially converts a KATCE type string into a C-type string. Also replaces all zero characters with space "$20".
;-----------------------------------------------------------

CR EQU $0D 
LF EQU $0A
SPACE EQU $20

main:
	
	;--- Output a prompt string.
	LEA PROMPT,A1
	MOVE.W	#$0D,-(SP)
	TRAP #4
	
	;-- Retrieve input from the user.
	LEA INSTR,A1
	MOVE.W #$07,-(SP)
	TRAP #4
	
SCANLOOP: ;-- Begin the scanning loop.
	CMP.B #CR,(A1)
	BEQ.B ADDNULL
	
	CMP.B #$30,(A1)
    	BNE.B SKIP
    	
    	MOVE.B #SPACE,(A1) ;-- Replace all zeroes with space characters.
    	JMP SCANLOOP
	
SKIP: ;-- Only increment the index of the string if the character is not zero.
	ADD #1,A1
    	JMP SCANLOOP	
	
	
ADDNULL:
	MOVE.B #$00,(A1) ;-- Replace the carriage return with the NULL terminator.
	
	;-- Output the modified string
	LEA INSTR,A1
	MOVE.W	#$0D,-(SP)
	TRAP #4
	
	
	RTS
	
	*--- All Constants go here
	*--- Note that KATCE does not operate on C-Type Strings.
	*--- Thus no null terminator is required and the string length must precede the string.
PROMPT: DC.B 5,"---> "
INSTR: DC.B 150
	
	END