	section .text

CR EQU $0D 
LF EQU $0A
SPACE EQU $20

main:
	
	*--- Output the string three times.
	LEA INSTR,A1
	MOVE.W	#$0D,-(SP)
	TRAP #4

	LEA INSTR,A1
	MOVE.W	#$0D,-(SP)
	TRAP #4

	LEA INSTR,A1
	MOVE.W	#$0D,-(SP)
	TRAP #4
LOOP:
	
	
	RTS
	
	*--- All Constants go here
	*--- Note that KATCE does not operate on C-Type Strings.
	*--- Thus no null terminator is required and the string length must precede the string.
INSTR: DC.B 7,"HELLO",CR,LF
	
	END