; Assignment 3 Problem 2
; Author: Jared Madden
; Date: 06/13/2016
; Program Description
;To reverse an array in place

INCLUDE Irvine32.inc


.data

array DWORD 1, 5, 6, 8, 0Ah, 1Bh, 1Eh, 22h, 2Ah, 32h  ;The array to reverse
brokenMsg byte "The changed array does not match the original."	
	
.code
	main proc
		
		mov ECX, lengthof array		;moves to ECX the length of the array
		mov ESI, 0					;changes ESI to 0
		mov EBX, sizeof array		;Moves to EBX the sizeof the array
		L1:							;First Loop to get the elements of the array
			mov EAX, 0				;Initialize EAX to 0
			mov EAX, array[ESI]		;Move the current element of array[esi] to EAX
			push EAX				;push that element on the stack
			add esi, TYPE array		;add to ESI the type of a single element in the array
			Loop L1					;Loop and decrement ECX
		mov ESI, 0					;Initialize ESI to 0 again
		mov ECX, lengthof array		;Initialize ECX again
		L2:							;Loop 2 to pop the elements of the array in reverse order, then place them back in the array
			pop EAX					;Pop the top element on the stack (the last element of array)
			Call WriteInt			;WriteInt for checking
			Call Crlf				;New line for checking
			mov array[esi], EAX		;Move the popped value in EAX to the element at array[esi]
			add esi, TYPE array		;increment esi by the type of a single array element
			Loop L2					;continue the loop and decrement ECX
		mov EDX, sizeof array		;move the size of the new array to EDX
		cmp EBX, EDX				;Compares the 2 array sizes to make sure they have the same number of elements
		je Finish					;If zero flag is true after comparison, no errors, jump to finish
		
		mov EDX, OFFSET brokenMsg	;If zero flag is false, the arrays didn't match(error checking)
		call WriteString		
		call Crlf
		jmp Finish
		
		
			
			
		
	Finish:
		call WaitMsg			 ;Displays a message and waits for a key to be pressed
		exit			
		main endp
	end main