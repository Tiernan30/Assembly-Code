; Title               : Hello World(HelloWorld.asm)
; Program Description : Write an Assembly program that display Hello World.
; Author              : robustprogramming.com
; Architecture        : Intel x86
; Library             : Irvine32
; Assembler           : Microsoft Macro Assembler (MASM 32-bit) version (12.0)
; Interface           : Console
; IDE                 : Microsoft Visual Studio Ultimate 2013

 
INCLUDE Irvine32.inc
 
.DATA
	; insert variables here
	prompt BYTE "Hello World!",0    ; A null-terminated string
 
.CODE
	; insert all executable statements here
	main PROC
		mov edx, OFFSET prompt ; "Hello World!"
		call WriteString       ;  Display a null-terminated string.
 
		call Crlf       ; Writes an end-of-line sequence to the console window.
		call WaitMsg    ; Displays a message and waits for a key to be pressed.
	exit     ; The exit statement indirectly calls a predefined
             ; MS-Windows function that halts the program.
 
main ENDP    ; The ENDP directive marks the end of the main procedure.
END main     ; The END directive marks the last line of the program to be assembled.
