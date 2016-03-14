*-----------------------------------------------------------
* Title      : ASCII Bitwise operations.
* Written by : Kaan Ozcelik
* Date       : 11.3.2016
* Description: Text input and parity bitwise control.
*-----------------------------------------------------------
CR EQU $0D 
LF EQU $0A
SPACE EQU $20

START: ORG    $1000 
    
    MOVE.L #28,D3 *-- The Loop Counter
    
    LEA EXPONENT,A2
    MOVE.L (A2),D1
    MOVE.B #3,D0
    TRAP #15
    
    ADD #1,D1
    MOVE.L D1,EXPONENT
    
    
    
    LEA SPACEBAR,A1 *-- Print a space
    MOVE.B #14,D0
    TRAP #15
    
    LEA ACTUAL,A2
    MOVE.L (A2),D1
    MOVE.B #3,D0
    TRAP #15
    
    LEA NULLSTR,A1 *-- Skip a line
    MOVE.B #13,D0
    TRAP #15
    
LOOP:
    ADD.L D1,D1 *-- Add the number to itself effectively doubling it, using the MULU command limits doubling to 16-Bit numbers.
    MOVE.L D1,ACTUAL
    
    LEA EXPONENT,A2
    MOVE.L (A2),D1
    MOVE.B #3,D0
    TRAP #15
    
    ADD #1,D1
    MOVE.L D1,EXPONENT
    
    LEA SPACEBAR,A1 *-- Print a space
    MOVE.B #14,D0
    TRAP #15
    
    LEA ACTUAL,A2
    MOVE.L (A2),D1
    MOVE.B #3,D0
    TRAP #15
    
    LEA NULLSTR,A1 *-- Skip a line
    MOVE.B #13,D0
    TRAP #15
    DBRA D3,LOOP
    
    
    
    
    
    


*-- Definitions --

NULLSTR: DC.B '',CR,LF,'',0
TESTSTR: DC.B 'TEST',0
SPACEBAR: DC.B SPACE,0

EXPONENT: DC.L 1
ACTUAL: DC.L 2


    END    START        ; last line of source





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
