; Program Template
; Author: Jared Madden
; Date:
; Program Description

.386
.model flat, stdcall
.stack 4096
ExitProcess proto,dwExitCode:dword



.data
	var1 BYTE 10h 		
	var2 SBYTE -128 	
	var3 WORD 2000h     
	var4 SWORD +2345	
	var5 DWORD 12345678h
	var6 SDWORD -2345678
	var7 FWORD 0
	var8 QWORD 1234567812345678h
	var9 TBYTE 12345678912345678911h
	var10 REAL4 -1.25
	var11 REAL8 3.2E+100
	var12 REAL10 -6.223424E-2343
	
.code
	main proc
		mov AX, var3	
		
		invoke ExitProcess,0
	main endp
	end main