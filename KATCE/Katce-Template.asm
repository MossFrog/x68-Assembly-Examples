	section .text

CR EQU $0D 
LF EQU $0A
SPACE EQU $20

main:
	
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
INSTR: DC.B 7,"HELLO",CR,LF
	
	END