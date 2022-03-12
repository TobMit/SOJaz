TITLE MASM Template(main.asm)
INCLUDE Irvine32.inc
.data

najmeCisl DB "Najmensie cislo je: ", 0
Vporadi DB "V poradi (cisluje sa od 0): ", 0

poleCisel DD 0, 4, 8, -6, 10, 11, 68, -54, 21, 0ffffffffh
poradoveCislo DD 0

.code

main PROC
	call Clrscr; VyËistenie s konzole
	xor edi, edi
	xor ecx, ecx
	xor ebx, ebx
	lea ebx, poleCisel			; offset poæa pre nepriame adresovanie
	mov eax, [ebx + edi]		; eax bude obsahovaù najmensie najdene cislo

	Cyklus:
		mov ecx, [ebx + (edi * 4)]	; poradovÈ cislo sa n·soby 4 preto lebo dd m· 4B
		cmp ecx, eax
		jl Nasiel
		cmp ecx, 0ffffffffh			; Overuje sa koniec poæa
		je Vystup
		inc edi
		jmp Cyklus

	Nasiel:
		mov poradoveCislo, edi		; do premennej sa ulozi poradie najdeneho najmensieho cisla
		mov eax, ecx				; v eax sa nahradi predchadzaj˙ce najmensie cislo aktu·lnym najmensim cislom
		inc edi
		jmp Cyklus

	Vystup:
		mov edx, offset najmeCisl	; V˝pis hlasky
		call WriteString
		call WriteInt				; v eax je aktualne najmensie cislo ktorÈ sa vypise
		call Crlf
		mov edx, offset Vporadi
		call WriteString
		mov eax, poradoveCislo		;najmensie cislo sa nahradi poradovym cislom re vypis
		call WriteInt
		call Crlf
		exit
	
exit
main ENDP
END main

