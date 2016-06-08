;Program
;Author
;Date

INCLUDE Irvine32.inc


SYSTEMTIME STRUCT

	wYear		  WORD	?
	wMonth	      WORD	?
	wDayOfWeek	  WORD	?
	wDay		  WORD	?
	wHour		  WORD	?
	wMinute		  WORD	?
	wSecond		  WORD	?
	wMilliseconds WORD	?

SYSTEMTIME ENDS


	
.data
	sysTime SYSTEMTIME <>
	msgTitle BYTE	"Displays the current Time and Date in Assembly.", 0
	msgTime BYTE	"Current Time is: ", 0
	msgDate BYTE	"Current Date is: ", 0



.code
main proc
	mov EDX, OFFSET msgTitle
	Call WriteString
	call Crlf
	
	INVOKE  GetLocalTime, ADDR sysTime  ;Call the microsoft windows GetLocalTime Function
										;and pass it the address of our SYSTEMTIME data structure
										;variable
	
	;For time "Hour - Minute - Second - Millisecond"
	mov EDX, OFFSET msgTime
	Call WriteString
	
	
	movzx EAX, sysTime.wHour
	call WriteDec				;Display an unsigned 32-bit integer value
	
	mov AL, '-'
	call WriteChar
	
	movzx EAX, sysTime.wMinute
	Call WriteDec
	
	mov AL, '-'
	call WriteChar
	
	movzx EAX, sysTime.wSecond
	Call WriteDec
	
	mov AL, '-'
	call WriteChar
	
	movzx EAX, sysTime.wMilliseconds
	Call WriteDec
	Call Crlf
	
	;for date, "Day-Month-Year"
	mov EDX, OFFSET msgDate
	Call WriteString
	
	movzx EAX, sysTime.wDay
	Call WriteDec
	
	mov AL, '-'
	call WriteChar
	
	movzx EAX, sysTime.wMonth
	Call WriteDec
	
	mov AL, '-'
	call WriteChar
	
	movzx EAX, sysTime.wYear
	Call WriteDec
	Call Crlf
	
	Call WaitMsg
	exit


main endp
end main