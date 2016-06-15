;Program
;Author
;Date

INCLUDE Irvine32.inc
.data
	intArray 	SWORD 0,0,0,0,-13,20,35,-12, 56
	nonZeroMsg 	BYTE "A non-zero value was not found.",0

.code
main proc
	mov EBX, OFFSET intArray		;Point to the array
	mov ECX, LengthOf intArray		;Loop counter
	
L1:	cmp WORD ptr [EBX], 0			;Compare values to 0
	jnz found						;Value found
	add EBX, 2						;Iterate the offset to point to the next value in the array
	loop L1							;Continue the loop
	jmp notfound	

found:								;display the value that was found
	movsx EAX, WORD ptr [EBX]		;Sing-extend into EAX
	call WriteInt
	jmp quit
	
notfound:
	mov EDX, OFFSET nonZeroMsg
	call WriteString
	
quit:
	call Crlf
	call WaitMsg
	exit


main endp
end main