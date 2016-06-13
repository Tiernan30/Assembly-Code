; Assignment 3 Problem 1
; Author: Jared Madden
; Date: 06/13/2016
; Program Description
;To calculate the balance of a user's checking account at the end of a day

Include Irvine32.inc


.data
	startBalance WORD 1000 			;The initial balance
	deposits WORD 150, 100, 450		;The deposits in array form, each is the total deposit, length is # of deposits
	withdraws WORD 100, 50			:The withdraws in array form, each is total withdraws, length is # of withdraws
	finalBalance WORD ?				;The final balance after withdraws and deposits have been made to startBalance balance
	finalMSG BYTE "Your final balance is: ",0  ;a final message to print the final balance to the screen
	
.code
	main proc
	mov EAX, 0						;clear EAX of garbage
	mov AX, startBalance			;Move the 32-bit integer of startbalance to AX
	mov ECX, lengthof deposits		;move the # of elements in deposites to ECX
	mov ESI, OFFSET deposits		;Move the memory location of deposits to ESI
	L1:								;Loop 1, to loop through the deposits array
		add AX, [esi]				;add the amount at the first location in ESI (1st in deposits) to AX
		add ESI, 2					;Increment the ESI mem location by 2
		Loop L1						;Continue the loop, decrement ECX by 1
	mov ECX, lengthof withdraws  	;Move the number of elements of withdraws to ECX
	mov ESI, OFFSET withdraws		;Move the mem location of withdraws to ESI
	L2:								;Loop 2 to loop through the withdraws array.
		sub AX, [esi]				;subtract the value at the esi location referencing withdraws
		add ESI, 2					;Increment ESI by 2
		Loop L2  					;Continue the loop
	mov finalBalance, AX			;Move the final value of AX to finalBalance
	mov EDX, OFFSET finalMSG		;Move the finalMSG mem location to EDX
	call WriteString				;Print the message to the screen
	call Crlf						;Print a new line
	
	call WriteInt					;Print the value in EAX to the screen(same as finalBalance)
	call Crlf						;New Line	
	
	call WaitMsg					;Wait message for user prompt to end program
	exit
	main endp
	end main