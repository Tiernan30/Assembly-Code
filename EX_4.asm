; Program Template
; Author: Jared Madden
; Date:
; Program Description

.386
.model flat, stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

stm1 TEXTEQU <"System failure">
stm2 TEXTEQU <"Press any key to continue...">
stm3 TEXTEQU <"Insufficient user training.">
stm4 TEXTEQU <"Please restart the system.">


.data
	msg1 BYTE stm1
	msg2 BYTE stm2
	msg3 BYTE stm3
	msg4 BYTE stm4
	
	
	
	
	
.code
	main proc
		
		
		invoke ExitProcess,0
	main endp
	end main