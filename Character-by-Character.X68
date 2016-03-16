*-----------------------------------------------------------
* Title      : String Character by Character
* Written by : Kaan Ozcelik
* Date       : 17.3.2016
* Description: Prints a String out Character by Character.
*-----------------------------------------------------------
CR EQU $0D 
LF EQU $0A
SPACE EQU $20

START: ORG    $1000 
    
    MOVE.B #0,D3
    LEA TESTSTR,A2
    CLR.L D2
    MOVE.B (A2),D2
    MOVE.B D2,D1
    MOVE.B #6,D0
    TRAP #15
    
LOOP:
    ADD #1,A2
    MOVE.B (A2),D1
    TRAP #15
    CMP.B D1,D3
    BEQ ENDP
    JMP LOOP
ENDP:
    LEA NULLSTR,A1
    MOVE.B #13,D0
    TRAP #15
    
    LEA END_MESSAGE,A1
    TRAP #15
    
    


*-- Definitions --

NULLSTR: DC.B '',CR,LF,'',0
TESTSTR: DC.B 'TEST',0
SPACEBAR: DC.B SPACE,0
END_MESSAGE: DC.B '--- END ---',0


    END    START        ; last line of source






*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
