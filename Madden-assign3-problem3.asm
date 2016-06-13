; Assignment3 problem 3
; Author: Jared Madden
; Date:06/13/2016
; Program Description
;To calculate and print the first 7 digits of the fibionacci sequence

INCLUDE Irvine32.inc


.data
	fibArray DWORD 7 Dup(0)  ;The array to store the sequence
	
.code
	main proc
		mov EAX, 0						;Intialize registers
		mov EBX, 0		
		mov ESI, 0
		mov ECX, 5						;Initialize ECX to 5 for our counter of the sequence after the first 2 numbers
		mov fibArray[esi], 1			;Add the first number(1) to the array
		mov fibArray[esi+4], 1			;Add the second number(1)to the array
		add ESI, 8						;Change our point to the 3rd element in the array
		L1:								;Loop to add the previous to elements to create the next element in the sequence
			mov EAX, fibArray[esi-4]	;Move the previous element into EAX
			mov EBX, fibArray[esi-8]	;Move the element before the previous into EBX
			add EAX, EBX				;Add the elements together
			call WriteInt				;Print to screen for error checking
			Call Crlf
			mov fibArray[esi], EAX		;Add the new element to the array
			add ESI, 4					;Increment the pointer to the next element
			Loop L1						;Decrements ECX, and continues the loop
			
			
			
		Call WaitMsg
		exit
	main endp
	end main