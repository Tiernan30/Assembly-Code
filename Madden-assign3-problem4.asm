; Assignment 3 problem 4
; Author: Jared Madden
; Date:06/13/2016
; Program Description
;To reverse a big endian number to little endian
INCLUDE Irvine32.inc


.data
bigEndian Byte 12h, 34h, 56h, 78h		;The bigEndian array
littleEndian DWORD ?					;The littleEndian array
	
.code
	main proc
	mov EAX, 0							;Initialize EAX to 0
	mov ECX, lengthof bigEndian			;move the length of bigEndian to ECX
	mov EAX, ECX						;Move ECX to EAX
	sub EAX, TYPE bigEndian				;Subtract from EAX the type of an element of bigEndian(in this case 1)
	mov ESI, EAX						;Move the new value in EAX to ESI
		L1:								;Loop to go backwards through bigEndian and move the elements to littleEndian
			movzx EAX, bigEndian[ESI]	;Move the current element in bigEndian into EAX(starting with the last)
			Call WriteInt				;Print screen for error checking
			Call Crlf
			mov littleEndian, EAX		;Move the element to the littleEndian array
			sub ESI, TYPE bigEndian		;Decrement our pointer by the type of the bigEndian array
			Loop L1						;Decrement ECX and continue the loop
		
		Call WaitMsg					;For error checking, brings a window awaiting any key to be pressed to continue
		exit	
	main endp
	end main