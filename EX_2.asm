; Program Template
; Author: Jared Madden
; Date:
; Program Description

.386
.model flat, stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword

Sunday 		= 0
Monday		= 1
Tuesday 	= 2
Wednesday 	= 3
Thursday 	= 4
Friday 		= 5
Saturday 	= 6

.data
	myDays BYTE Sunday, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday
.code
	main proc
		mov EAX, Monday
		mov EBX, Friday
		mov ECX, Tuesday
		mov EDX, Wednesday
				
				
		invoke ExitProcess,0
	main endp
	end main