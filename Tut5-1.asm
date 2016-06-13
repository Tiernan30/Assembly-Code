; Program Tutorial 5 -1
; Author: Jared Madden
; Date: June 6, 2016
; Program Description

INCLUDE Irvine32.inc



.DATA
	msgTitle 		BYTE "Assembly program to check if a character is a Vowel or a Consonant.", 0 ;A null terminated String
	prompt 			BYTE "Enter an alphabet character: ", 0
	msgVowel 		BYTE "Character is a Vowel.", 0
	msgConsonant 	BYTE "Character is a Consonant.", 0
	msgIsDigit  	BYTE "Character was a number, please enter an alphabet character.", 0
	
	
	
.code
	main proc
		mov edx, OFFSET msgTitle ;Move the msgTitle message to edx.
		call WriteString 		 ;Displays our message.
		call Crlf				 ;Write an end-of-line sequence to the console window.
		
		;Display message on console for input
		mov edx, OFFSET prompt ;Move the prompt message to edx
		call WriteString	   ;Displays the message
		call ReadChar		   ;Waits and reads 1 character from the user and returns that character, stores in AL
		call WriteChar		   
		
		call Crlf
		
		call IsDigit		   ;Sets the Zero flag to true(1) if the AL register contains the ASCII code for a decimal digit (0-9).
		jz Digit					   ;Jumps to a place in the code if zero flag is true
		
		cmp AL, 'a'				;Comparing what is in AL to 'a'.
		je Vowel				;If Zero flag is true after compare, jump to Vowel
		
		cmp AL, 'e'
		je Vowel
		
		cmp AL, 'i'
		je Vowel
		
		cmp AL, 'o'
		je Vowel
		
		cmp AL, 'u'
		je Vowel
		
		cmp AL, 'A'
		je Vowel
		
		cmp AL, 'E'
		je Vowel
		
		cmp AL, 'I'
		je Vowel
		
		cmp AL, 'O'
		je Vowel
		
		cmp AL, 'U'
		je Vowel
		
		mov edx, OFFSET msgConsonant ;Move the msgConsonant message to edx.
		call WriteString 		 ;Displays our message.
		call Crlf				 ;Write an end-of-line sequence to the console window.
		jmp Finish
	
	Vowel:
		mov edx, OFFSET msgVowel ;Move the msgVowel message to edx.
		call WriteString 		 ;Displays our message.
		call Crlf				 ;Write an end-of-line sequence to the console window.
		jmp Finish
			
	Digit:
		mov edx, OFFSET msgIsDigit;Move the msgIsDigit message to edx.
		call WriteString 		 ;Displays our message.
		call Crlf				 ;Write an end-of-line sequence to the console window.

	
	Finish:
		call WaitMsg			 ;Displays a message and waits for a key to be pressed
		exit
		main endp
	end main