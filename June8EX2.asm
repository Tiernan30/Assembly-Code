;Program
;Author
;Date

INCLUDE Irvine32.inc
.data
	a WORD 0
	b WORD 0
	msgTitle  BYTE "Display dd numbers between two given numbers.", 0
	msgStarting BYTE "Please enter the first number: ", 0
	msgEnding  BYTE  "Please enter the last the number: ", 0
	msgOdd   BYTE   "Odd numbers are: ", 0
	
.code
main proc
	mov EDX, OFFSET msgTitle
	call WriteString
	call Crlf
	
	mov EDX, OFFSET msgStarting
	call WriteString
	
	call ReadInt   ;To read user input of a 16-bit signed decimal number from keyboard and save it in EAX
	
	mov a, AX
	
	mov EDX, OFFSET msgEnding
	call WriteString
	
	call ReadInt
	
	mov b, AX
	
	mov EDX, OFFSET msgOdd
	call WriteString
	call Crlf
	
	mov EAX, 0
	
	;Set the starting number of the series
	
	mov BL, 2 ;To determine if a number is even of odd, by dividing
	mov SI, a
	
L1:
	cmp SI, b 
	jnle next

	mov AX, SI
	div BL
	
	
	cmp AH, 0  ;To check if the division had a remainder
	
	je Increment  ;jump if equal (=)
	
	movsx  EAX, si
	call WriteDec ;Display an unsigned 32-bit integer value in EAX in decimal format
	call Crlf
	
Increment:
	inc ESI
	jmp L1
	
	
Next:
	call WaitMsg
	exit
	
main endp
end main