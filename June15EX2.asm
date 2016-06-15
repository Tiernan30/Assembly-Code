;Program
;Author
;Date

INCLUDE Irvine32.inc

KEY = 239				;Any value between 1-255
BUFMAX = 128			;Maximum Buffer size

.data
	promptMsg 	BYTE 	"Enter the plain text: ", 0
	EncryptMsg  BYTE  	"Cipher text: ", 0
	decryptMsg	BYTE	"Decrypted text: ", 0
	buffer		BYTE	BUFMAX + 1 DUP(0)
	bufSize		DWORD	?
	
.code
main proc
	call InputTheString			;Input the plain text
	call TranslateBuffer		;Encrypt the Buffer
	
	mov EDX, OFFSET EncryptMsg
	call DisplayMessage
	call TranslateBuffer		;Decrypt the Buffer
	
	mov EDX, OFFSET decryptMsg
	call DisplayMessage
	
	exit
main endp

InputTheString proc
	pushad						;To save 32-bit registers
	
		mov EDX, OFFSET promptMsg
		call WriteString
		
		mov ECX, BUFMAX				;Maximum Character count
		mov EDX, OFFSET buffer		;Point to the buffer
		call ReadString				;Input the plain text
		mov bufSize, EAX			;To save the length of the input string
		call Crlf
	
	
	popad
	ret
InputTheString endp

TranslateBuffer proc
	pushad
		mov ECX, bufSize			;Loop counter
		mov ESI, 0
		
	L1: xor buffer[ESI], KEY		;Translating a Byte
		inc ESI						;Point to the next Byte
		Loop L1
	
	popad
	ret
TranslateBuffer endp

DisplayMessage proc
	pushad
		call WriteString
		mov EDX, OFFSET buffer		;Display the buffer
		Call WriteString
		call Crlf
	
	popad
	ret
DisplayMessage endp
end main