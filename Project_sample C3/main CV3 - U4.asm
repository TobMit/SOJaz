TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data
retazec BYTE "language",0

.code
main PROC
	call Clrscr
	xor al, al		;Nulujem register kde uklada ReadChar znak ktor� som zadal
	call ReadChar	;ulo�� znak ktor� som zadal do Al


	xor edi, edi				;edi a esi s� indexov� registre - sl��i ako poradov� �islo v retazci
	xor esi, esi				;pocet vyskytov
	L1:
		mov bl, retazec[edi]	;nahr� sa znak na mieste edi
		inc edi					;zv��i sa poradov� ��slo 
		cmp bl, 0				;porov�va rezatec �i je na konci (na konci je 0)
		je L2					;Ak �no tak sko�� do L2 ak nie pokra�uje

		cmp bl,al				;Porovn� znak ktor� som zadal so znakom v pole
		jne L1					;Ak nie s� rovnak� sko� na L1 ak �no pokra�uj da�ej
		inc esi					;Zv�� hodnotu po�tu v�skytu
		jmp L1					;pokra�uj z da���m v�po�tom


	

	L2:
		mov eax, esi			;prehod� hodnotu do eax z ktor�ho ��ta WriteInt
		call WriteInt			;nap�e ��slo ktor� som si ulo�il
	exit
main ENDP

END main