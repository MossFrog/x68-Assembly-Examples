*-----------------------------------------------------------
* Title      : Single Character Parity Bit
* Written by : Kaan Ozcelik
* Date       : 21.3.2016
* Description: Utilizes 8-Bit ascii and sets the leftmost bit to 1 or 0 according to the number of 1's.
*-----------------------------------------------------------
CR EQU $0D 
LF EQU $0A
SPACE EQU $20

START: ORG    $1000

    *-- Register for storing the current index -> D5
    *-- The program alternates the parity bit (at index 7) whenever it encounters a "1" 
    
    LEA PROMPT,A1 *-- Display the prompt string
    MOVE.B #14,D0
    TRAP #15 
    
    MOVE.B #5,D0 *-- Get a single ASCII character and store in D1.B
    TRAP #15
    
    LEA NULLSTR,A1
    MOVE.B #13,D0
    TRAP #15
    
    CLR.L D5 *-- Clear the registers.
    CLR.L D6

TSTLOOP: *-- Loop for checking each bit until the leftmost
    CMP.B #7,D5 *-- Check if the last bit has been compared, else continue
    BEQ END

    BTST D5,D1 *-- Test the bit at index D5
    BEQ ZERO *-- Branch to ZERO if '1'
    BNE ONE *-- Branch to ONE if '0'

ONE:
    ADD.B #1,D5 *-- Add one to the index
    BCHG #7,D1 *-- Invert the bit at index 7 (leftmost)
    JMP TSTLOOP *-- Return to the testloop
    
ZERO:
    ADD.B #1,D5 *-- Add one to the index
    JMP TSTLOOP *-- Return to the testloop
    
    
PRINT:
    BTST D5,D2
    BEQ PRINTSUB0
    BNE PRINTSUB1
    
    
PRINTSUB1:
    MOVE.B #$31,D1
    MOVE.B #6,D0
    TRAP #15
    SUB.B #1,D5
    
    CMP.L #$FF,D5
    BEQ ENDPRINT
    JMP PRINT
    

PRINTSUB0:
    MOVE.B #$30,D1
    MOVE.B #6,D0
    TRAP #15
    SUB.B #1,D5
    
    CMP.L #$FF,D5
    BEQ ENDPRINT
    JMP PRINT


ENDPRINT:
    RTS
    
END:
    *-- Print the new bit-string with the altered parity bit --*
    LEA NULLSTR,A1 *-- Skip a line
    MOVE.B #13,D0
    TRAP #15
    
    MOVE.L D1,D2 *-- Move the contents of D1 into D2 for preservation.
    JSR PRINT
    
    LEA NULLSTR,A1 *-- Skip a line
    MOVE.B #13,D0
    TRAP #15
    
    

    LEA END_MESSAGE,A1 *-- Display the END of program message
    MOVE.B #13,D0
    TRAP #15    
    
    *-- Halt the Simulator --*
    
    SIMHALT

    


*-- Definitions --*

NULLSTR: DC.B '',0
PROMPT: DC.B '--> ',0
SPACEBAR: DC.B SPACE,0
END_MESSAGE: DC.B '--- END ---',0
ODDSTR: DC.B 'ODD',0
EVENSTR: DC.B 'EVEN',0
ORIGINAL: DC.B 'ORIGINAL',0


    END    START        ; last line of source







*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
