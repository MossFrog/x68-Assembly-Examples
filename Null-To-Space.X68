*-----------------------------------------------------------
* Title      :  NULL TO SPACE
* Written by :  Kaan Ozcelik
* Date       :  5.4.2016
* Description:  Simple Program that replaces all "0" characters with as space character.
*-----------------------------------------------------------
CR EQU $0D 
LF EQU $0A
SPACE EQU $20


START:  ORG    $1000
    
    LEA INSTR,A1
    MOVE.B #2,D0
    TRAP #15
    
SCANLOOP:
    CMP.B #$0,(A1)
    BEQ END
    
    CMP.B #$30,(A1)
    BNE SKIP
    
    
    MOVE.B #$20,(A1)
    JMP SCANLOOP
    
SKIP:
    ADD #1,A1
    JMP SCANLOOP
    
END:
    LEA INSTR,A1
    MOVE.B #13,D0
    TRAP #15



*-- Halt the simulator --*
    SIMHALT
    
    
*--- Definitions ---*
NULLSTR: DC.B '',0
PROMPT: DC.B '--> ',0
SPACEBAR: DC.B SPACE,0
INSTR: DC.B 150
END_MESSAGE: DC.B '--- END ---',0


    END    START

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
