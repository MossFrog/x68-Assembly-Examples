*-----------------------------------------------------------
* Title      : Hello World
* Written by : Kaan Ozcelik
* Date       : 5.3.2016
* Description: Hello World Example
*-----------------------------------------------------------

START: ORG    $1000  ; first instruction of program

    LEA MESSAGE,A1
    MOVE.B #14,D0
    TRAP #15
    
    MOVE.B #9,D0
    TRAP #15


CR EQU $0D 
LF EQU $0A
MESSAGE DC.B 'HELLO WORLD',CR,LF
        DC.B 'TEST LINE 2',CR,LF,CR,LF
        DC.B 'TEST SKIP LINE',0

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
