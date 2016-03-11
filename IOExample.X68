*-----------------------------------------------------------
* Title      : IO
* Written by : Kaan Ozcelik
* Date       : 11.3.2016
* Description: Inputs and Outputs
*-----------------------------------------------------------
CR EQU $0D 
LF EQU $0A

START: ORG    $1000 

    LEA MESSAGE,A1
    MOVE.B #14,D0
    TRAP #15
    
    MOVE.B #4,D0
    TRAP #15
    
    *-- Move the value stored at D1 to D5 --
    MOVE.L D1,D5
    ADD D1,D5
    
    MOVE D5,D1
    MOVE.B #3,D0
    TRAP #15
    


*-- Definitions --

MESSAGE DC.B 'Welcome to a simple IO Example',CR,LF
        DC.B 'Please enter a number : ',0

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
