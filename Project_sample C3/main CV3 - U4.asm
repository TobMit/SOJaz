TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data
retazec BYTE "language",0

.code
main PROC
	call Clrscr
	xor al, al		;Nulujem register kde uklada ReadChar znak ktorý som zadal
	call ReadChar	;uloží znak ktorí som zadal do Al


	xor edi, edi				;edi a esi sú indexové registre - slúži ako poradové èislo v retazci
	xor esi, esi				;pocet vyskytov
	L1:
		mov bl, retazec[edi]	;nahrá sa znak na mieste edi
		inc edi					;zvýši sa poradové èíslo 
		cmp bl, 0				;porováva rezatec èi je na konci (na konci je 0)
		je L2					;Ak áno tak skoèí do L2 ak nie pokraèuje

		cmp bl,al				;Porovná znak ktorý som zadal so znakom v pole
		jne L1					;Ak nie sú rovnaké skoè na L1 ak áno pokraèuj da¾ej
		inc esi					;Zvýš hodnotu poètu výskytu
		jmp L1					;pokraèuj z da¾ším výpoètom


	

	L2:
		mov eax, esi			;prehodí hodnotu do eax z ktorého èíta WriteInt
		call WriteInt			;napíše èíslo ktoré som si uložil
	exit
main ENDP

END main