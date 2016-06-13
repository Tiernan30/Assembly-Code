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
	mov eax, DWORD ptr bigEndian		;The ptr command automatically reverses the bits when used, so
										;the elements of bigEndian are reversed and stored in eax
	mov littleEndian, EAX				;Then we just move those elements into the littleEndian array
	
		
		exit
	main endp
	end main