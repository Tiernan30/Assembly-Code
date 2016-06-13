; Summation
; Author: Jared Madden
; Date:June 6, 2016
; Program Description

INCLUDE Irvine32.inc

.data
	a DWORD 0
	b DWORD 0
	sum DWORD 0
	msgTitle BYTE "Sum of consecutive numbers between given numbers", 0 ;A null-terminated String
	msgStarting BYTE "Enter Starting number: ", 0
	msgEnding BYTE "Enter Ending number: ", 0
	msgSum BYTE "Sum = ", 0
	
.code
	main proc
		mov EAX, 0 ;resets EAX to 0 value so we can use the whole register for DWORDs
		
		mov EDX, OFFSET msgTitle 	;Reads the msgTitle
		call WriteString			;Displays the null-terminated String
		call Crlf					;Writes end-of-line sequence to console window
		
		mov EDX, OFFSET msgStarting 	;Reads the msgStarting
		call WriteString				;Displays a null-terminated String
		
		call ReadInt					;Reads the input 32-bit signed decimal integer from the keyboard and saves it in EAX
		mov a, EAX					;Moves the value in EAX to a
		
		mov EDX, OFFSET msgEnding 	;Reads the msgEnding
		call WriteString				;Displays a null-terminated String
		
		call ReadInt					;Reads the input 32-bit signed decimal integer from the keyboard and saves it in EAX
		mov b, EAX					;Moves the value in EAX to b.
		
		mov ESI, a 					;Moves the value of a to ESI 
		
	L1:
		cmp ESI, b					;Compares ESI with value in b.
		jnle displaySUM				;Jumps if not less than or equal to b !(<=)
		
		add sum, ESI				;If ESI is less than b, add the value to sum
		inc ESI						;Increment the value in ESI by 1
		jmp L1						;Jump back to the beginning of L1
		
		
	displaySUM:
		mov EDX, OFFSET msgSum		;Moves the last message to EDX
		call WriteString			;Displays a null-terminated String
		mov EAX, sum				;Moves the value in sum to EAX
		call WriteInt				;Writes whatever is in EAX to the console (signed 32-bit integer value in decimal)
		call Crlf					;Writes end-of-line sequence to console window
		
		
		
		call WaitMsg
		exit
		main endp
	end main