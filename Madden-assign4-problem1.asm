; CPSC355 Assignment 4
; Author: Jared Madden
; Date: June 22, 2016
; Program Description
; An atm simulation

INCLUDE Irvine32.inc


.data
	attempsCounter 			BYTE 3						;Max attempts for account authentication
	transactionsCounter		BYTE 3						;Max transactions **For Bonus**
	
	accountLocation         DWORD 0						;Temp variable for the index of the account
	pinNumber				WORD  0						;Temp variable for pin
	account					DWORD 0						;Temp variable for account#
	
	withdraws				DWORD 0						;total amount of withdraws
	deposits				DWORD 0						;total amount of deposits
	
	accountNumbers 			DWORD 10021331, 12322244, 44499922, 10222334								;account numbers array
	
	pins					WORD 2341, 3345, 1923, 3456													;pin numbers array
	
	Balances 				DWORD 1000, 0, 80000, 4521													;balances  array
	
	maxWithdraw				DWORD 1000																	;max withdraw amount
	
	startMsg 				BYTE "Please enter a valid account number: ", 0								;Start message for account number prompt
	pinMsg					BYTE "Please enter the pin number for this account: ", 0					;pin number prompt
	
	displayMenu				BYTE "Please choose an option below: ", 0dh, 0ah, 0dh, 0ah,					;Displays the main menu
								"1. Display Balance", 0dh, 0ah,
								"2. Withdraw", 0dh, 0ah,
								"3. Deposit", 0dh, 0ah,
								"4. Print Receipt", 0dh, 0ah,
								"5. Exit", 0
	withdrawMsg				BYTE "Please enter the amount you wish to withdraw(max of $1000): ", 0		;Withdraw message
	
	successfulWithdrawMsg	BYTE "Your withdraw was successful.", 0										;Successful withdraw message
	
	depositMenu				BYTE "Are you depositing a check or cash(in multiples of 10)?", 0dh, 0ah,	;Sub menu for deposit types
								"1. Check", 0dh, 0ah,
								"2. Cash", 0
	
	checkMsg				BYTE "Please enter the amount for your check deposit: ", 0					;Msg for check deposits

	cashMsg					BYTE "Please enter the amount of your cash deposit (in multiples of 10 only): ", 0	;Cash deposit msg
	
	successfulDepositMsg	BYTE "Your deposit was successful.", 0												;Successful deposit msg
	
	receiptMsg1				BYTE "Your account number is: ", 0													;Receipt print outs
	receiptMsg2				BYTE "Your current balance is: ", 0
	receiptMsg3				BYTE "Your total withdrawls today are: ", 0
	receiptMsg4				BYTE "Your total deposits today are: ", 0
							 
	balanceMsg				BYTE "Your current balance is: ", 0		;Display the current balance
	
	overdraftMsg			BYTE "Your requested withdraw exceeds the current balance or the maximum withdraw amount, please try again.", 0	;Overdraft/max withdraw error message
	
	outOfTransactionsMsg	BYTE "No more transactions available today.", 0		;Msg for transaction limit reached
	outOfTriesMsg			BYTE "No attempts to login left, exiting. ", 0 ;No more login attempts message
	
	pinErrorMsg				BYTE "Invalid pin for this account, please try again.", 0		;Wrong pin message
	
	badChoiceMsg			BYTE "That is not a valid choice, please try again.", 0			;For bad main menu input
		
.code

	
	main proc
		
		mov EAX, 0		;Set all used registers to 0
		mov EBX, 0
		mov ECX, 0
		mov EDX, 0
		mov ESI, 0
		
		
		mov BL, attempsCounter				;Move the number of attempts remaining to BL
		
		Prompt:							;Initial prompt jump location
			mov EDX, OFFSET startMsg	;Move the startMsg to EDX
			call WriteString			;Print the string to the console
			
			call ReadInt				;Get user input as an integer
			mov account, EAX			;Move the input to the account variable
			
			mov CL, Lengthof accountNumbers		;Move the length of accountNumbers array to CL
			mov ESI, OFFSET accountNumbers		;Move the accountNumbers mem location to ESI
			call Crlf							;Print a new line
			

			L1:									;First Loop to check if the entered account number matches any in the array
				mov EAX, DWORD PTR [ESI]		;Moves to EAX the accountNumbers element at position ESI
				cmp EAX, account 				;compares that to the entered account
				je PIN1							;if equal, jump to pin1
				add ESI, type accountNumbers	;else add to ESI the type of accountNumbers to goto next element
				add accountLocation, type accountNumbers	;update the accountLocation variable to the current accountNumbers index
				loop L1							;Decrement ECX, if still above 0 jump to L1
			sub BL, 1							;Subtract 1 from BL, holding our attempts counter if the entered account is invalid
			mov accountLocation, 0				;Reset the account location tracker
			cmp BL, 0							;Check if we have any attempts remaining
			ja Prompt							;If so, jump back to Prompt
			jmp outOfTriesLabel					;Else jump to outOfTriesLabel

		PIN1:									;First pin condition
			mov ECX, 0							;Resets ECX to 0
			mov ECX, accountLocation			;Moves to ECX the saved account location
			shr ECX, 1							;Shifts the number to the right by 1, dividing by 2(this is done because all the arrays are DWORDs save for pins, which is WORD, so 1/2 the index size)
			
		PIN2:									;Second Pin Condition, once we've converted the account location
			mov ESI, OFFSET pins				;Move the mem location of pins to ESI
			add ESI, ECX						;add to esi the converted account location
			mov EDX, OFFSET pinMsg				;move to EDX the offset of pinmsg
			call WriteString					;print to screen
			
			call ReadInt						;Prompt for user input
			mov pinNumber, AX					;mov the user input to pinNumber
			mov AX, WORD PTR [ESI]				;mov the pin array at location ESI to AX
			cmp pinNumber,  AX					;compare the entered pin number to the saved one
			je MainMenu							;if equal, jump to Main Menu
			sub BL, 1							;else sub BL by 1 (lowering our number of attempts)
			cmp BL, 0							;Check if BL = 0
			ja Reprompt							;if not, jump to reprompt
			jmp outOfTriesLabel					;else jump to outOfTriesLabel
		
		Reprompt:								;Reprompt condition if pin was wrong
			mov EDX, OFFSET pinErrorMsg			;Move pinErrorMsg mem location to EDX
			Call WriteString					;Print to screen
			call Crlf							;New Line
			jmp PIN2							;Jump back to pin2 for try again

		OutOfTriesLabel: 						;Out of attempts
			mov EDX, OFFSET outOfTriesMsg		;Move the outOfTriesMsg mem location to EDX
			Call WriteString					;Print to screen
			call WaitMsg						;Wait for key input
			exit								;exit the program
		
		MainMenu:								;Main menu condition
			mov EAX, 0							;Reset EAX to 0
			mov EDX, OFFSET displayMenu			;Move to EDX the mem location of displayMenu
			Call WriteString					;Print to screen
			
			Call ReadInt						;Read user input
			
			cmp EAX, 0							;compare input to 0, if below or equal, jump to BadChoice
			jbe BadChoice
			
			cmp EAX, 6							;Compare to 6, if above or equal, jump to BadChoice
			jae BadChoice
			
			cmp EAX, 1							;Compare to 1, if equal jump to DisplayBalance
			je DisplayBalance
			
			cmp EAX, 2							;Compare to 2, if equal jump to Withdraw
			je Withdraw
			
			cmp EAX, 3							;Compare to 3, if equal jump to Deposit
			je Deposit
			
			cmp EAX, 4							;Compare to 4, if equal jump to PrintReceipt
			je PrintReceipt
			
			cmp EAX, 5							;Compare to 5, if equal jump to EndProgram
			je EndProgram

		DisplayBalance:							;Display Balance Condition
			mov EDX, OFFSET balanceMsg			;Move balanceMsg mem location to EDX
			Call WriteString					;Print to screen
			Call Crlf							;New Line

			mov ESI, OFFSET Balances			;Move to ESI the mem location of the Balances array
			add ESI, accountLocation			;Add to ESI the account location
			mov EAX, 0							;Reset EAX to 0
			mov EAX, DWORD ptr [ESI]			;Move to EAX the value ESI points at in the array
			Call WriteDec						;print the value to screen
			call Crlf							;New line
			jmp MainMenu						;Jump back to main menu
		
		Withdraw:								;Withdraw condition
			cmp transactionsCounter, 0			;Compare our transactionsCounter to 0	
			jbe OutOfTransactions				;if below or equal, jump to OutOfTransactions
			
			mov EDX, OFFSET withdrawMsg			;Move withdrawMsg to EDX
			Call WriteString					;Print to screen
			
			mov EAX, 0							;Reset EAX to 0
			call ReadInt						;User input
			
			cmp EAX, maxWithdraw				;Compare EAX to the maxWithdraw amount
			ja Overdraft						;If over, jump to Overdraft
			
			mov EBX, EAX						;Move EAX to EBX
			mov ESI, OFFSET Balances			;Move to ESI the mem location of the Balances array
			add ESI, accountLocation			;add the accountLocation to ESI
			mov EAX, 0							;Reset EAX to 0
			mov EAX, DWORD ptr [ESI]			; move the value ESI points to in the array to EAX
			
			sub EAX, EBX						;Subtract from the value EBX
			cmp EAX, 0							;Compare the new value to 0
			jl Overdraft						;if it's less than 0, jump to Overdraft
			
			add withdraws, EBX					;else add EBX to withdraws
			sub transactionsCounter, 1			;decrement the transactionsCounter by 1 **FOR BONUS**
			mov DWORD ptr [ESI], EAX			;Move the new value to the location in the balances array
			mov EDX, OFFSET successfulWithdrawMsg	;move the mem location for successfulWithdrawMsg to EDX
			Call WriteString						;Print to screen
			Call Crlf								;New Line
			jmp DisplayBalance						;Jump to DisplayBalance
			
		Overdraft:									;Overdraft condition
			mov EDX, OFFSET overdraftMsg			;Move overdraftMsg mem location to EDX
			Call WriteString						;Print to screen
			Call Crlf								;new Line
			jmp MainMenu							;Jump to main menu
		
		Deposit:									;Deposit condition
			cmp transactionsCounter, 0				;Compare transactionsCounter to 0
			jbe OutOfTransactions					; if below or equal, jump to OutOfTransactions
			
			mov EDX, OFFSET depositMenu				;move depositMenu mem location to EDX
			Call WriteString						;Print to screen
			Call Crlf								;new line
			
			mov EAX, 0								;Reset EAX to 0
			call ReadInt							;Get user input
			
			cmp EAX, 0								;compare EAX to 0
			jbe BadChoice							;If below or equal, jump to BadChoice
			
			cmp EAX, 1								;Compare EAX to 1, if equal jump to Check
			je Check
			
			cmp EAX, 2								;Compare EAX to 2, if equal jump to Cash
			je Cash
			
			cmp EAX, 3								;Compare EAX to 3, if above or equal, jump to BadChoice
			jae BadChoice
			
		Check:										;Check condition
			mov EDX, OFFSET checkMsg				;Move to EDX the mem location of checkMsg
			Call WriteString						;Print to screen
			
			mov EAX, 0								;Reset EAX to 0
			call ReadInt							;Get user input
			
			add deposits, EAX						;Add EAX to deposits
			mov EBX, EAX							;Move EAX to EBX
			mov ESI, OFFSET Balances				;Move the mem location of Balances array to ESI
			add ESI, accountLocation				;Add to ESI the accountLocation
			mov EAX, 0								;Reset EAX
			mov EAX, DWORD ptr [ESI]				;Move to EAX the value at ESI of the Balances array
			add EAX, EBX							;Add EBX to EAX
			
			mov DWORD ptr [ESI], EAX				;Move the new value to the location in the array
			sub transactionsCounter, 1				;Decrement the transactionsCounter**BONUS**
			mov EDX, OFFSET successfulDepositMsg	;Move to EDX the successfulDepositMsg mem location
			Call WriteString						;Print to screen
			Call Crlf								;New line
			jmp DisplayBalance						;jump to DisplayBalance
			
		Cash:										;Cash Condition
			mov EDX, OFFSET cashMsg					;Move to EDX the mem location of cashMsg
			Call WriteString						;Print to screen
			
			mov EAX, 0								;Reset EAX to 0
			Call ReadInt							;Get user input
			
			add deposits, EAX						;Add the value to deposits
			mov EBX, EAX							;Move EAX to EBX
			mov ESI, OFFSET Balances				;Move to ESI the mem location of Balances array
			add ESI, accountLocation				;add to ESI the account location
			mov EAX, 0								;reset EAX
			mov EAX, DWORD ptr [ESI]				;Move the value in the array at ESI to EAX
			add EAX, EBX							;Add EBX to EAX
			
			mov DWORD ptr [ESI], EAX				;Move the new value into the array at position ESI
			sub transactionsCounter, 1				;Decrement the transactionsCounter**BONUS**
			mov EDX, OFFSET successfulDepositMsg	;Move to EDX the mem location of successfulDepositMsg
			Call WriteString						;Print to screen
			Call Crlf								;New Line
			jmp DisplayBalance						;Jump to DisplayBalance
			
		
		PrintReceipt:								;Print Receipt Condition
			mov EDX, OFFSET receiptMsg1				;move to EDX receiptMsg1 mem location
			Call WriteString						;Print to screen
			
			mov ESI, OFFSET accountNumbers			;move to ESI accountNumbers array mem location
			add ESI, accountLocation				;add the accountLocation to ESI
			mov EAX, 0								;Reset EAX to 0
			mov EAX, DWORD ptr [ESI]				;Move the value at ESI in the array to EAX
			Call WriteDec							;Print to screen
			call Crlf								;New Line
			
			mov EDX, OFFSET receiptMsg2				;move to EDX receiptMsg2 mem location
			Call WriteString						;Print to screen
			
			mov ESI, OFFSET balances				;move to ESI balances array mem location
			add ESI, accountLocation				;add the accountLocation to ESI
			mov EAX, 0								;reset EAX to 0
			mov EAX, DWORD ptr [ESI]				;Move the value at ESI in the array to EAX
			Call WriteDec							;Print to screen
			call Crlf								;New Line
			
			mov EDX, OFFSET receiptMsg3				;move to EDX receiptMsg3 mem location
			Call WriteString						;Print to screen
			
			mov ESI, OFFSET withdraws				;move to ESI withdraws array mem location
			mov EAX, 0								;reset EAX to 0
			mov EAX, DWORD ptr [ESI]				;Move the value at ESI to EAX
			Call WriteDec							;Print to screen
			call Crlf								;New Line
			
			mov EDX, OFFSET receiptMsg4				;move to EDX receiptMsg4 mem location
			Call WriteString						;Print to screen
			
			mov ESI, OFFSET deposits				;move to ESI deposits array mem location
			mov EAX, 0								;reset EAX to 0
			mov EAX, DWORD ptr [ESI]				;Move the value at ESI to EAX
			Call WriteDec							;Print to screen
			call Crlf								;New Line
			
			jmp MainMenu							;Jump to MainMenu
			
			
			
		OutOfTransactions:							;Out of Transactions condition
			mov EDX, OFFSET outOfTransactionsMsg	;Move to EDX the mem location of outOfTransactionsMsg
			Call WriteString						;Print to screen
			Call Crlf								;new line
			jmp MainMenu							;Jump to MainMenu
			
		BadChoice:									;Bad choice condition
			mov EDX, OFFSET badChoiceMsg			;Move to EDX the mem location of badChoiceMsg
			Call WriteString						;Print to screen
			Call Crlf								;New line
			jmp MainMenu							;Jump to MainMenu
		
		EndProgram:									;End Program condition
			Call WaitMsg							;Wait message for user input
			exit									;exit the program
	main endp
	end main