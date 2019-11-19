.ORIG x3000
LD R1, SAVED_STRING_ADDRESS	;Load x3100 into R1 from offset xff on PC

AND R3,R3,#0	;AND R3 W/ 0 TO CLEAR R3
ADD R3,R3,#10	;ADD #10 TO #0 AND STORE IN R3
NOT R3, R3      ;Invert R3
ADD R3, R3, #1  ;Add 1 (twos compliment) Creates -10 in R3;
LEA R2, #0     	;Load x3006 into R2 from offset #0 on PC;

;; Get Input From user
TRAP x23 		;Get a character from the user (it goes in R0)

;; Check to see if its a new line character
ADD R4, R0, R3  ;Add the input to R3 and store in R4
BRz #3       	;If the result set the Z flag we know it was a newline character (enter);

;; Store the input
STR R0, R1, #0  ;Store the input
ADD R1, R1, #1  ;Add one to the address in R1

;; Continue the loop
JMP R2

;; Branch goes here if input was a newline
AND R0, R0, #0  ;Clear R0
STR R0, R1, #0  ;Store x0000 at the end of user input (remember null-terminated strings)
halt

SAVED_STRING_ADDRESS .FILL x3100
.END			;Halt Program