TITLE MASM Template(main.asm)
INCLUDE Irvine32.inc
.data

dlzkaPola equ 10

najmeCisl DB "Najmensie cislo je: ", 0
Vporadi DB "V poradi (cisluje sa od 0): ", 0
Uvod DB "Nacitajte cisla do pola!", 0Dh,0Ah, 0

poleCisel DD dlzkaPola dup(0)
poradoveCislo DD 0

.code

main PROC
	call Clrscr; Vy�istenie s konzole
	xor edi, edi
	xor ecx, ecx
	xor ebx, ebx
	mov edx, offset Uvod
	call WriteString
	xor edx, edx


	Nacitavanie:
		cmp edi, dlzkaPola				; Testuje sa �i u� nieje pole na konci
		je Priprava						; ak ano tak sa sko�� na pr�pravu

		call ReadInt
		mov poleCisel[edi * 4], eax		; inform�cie sa ulo�ia do pola a n�sobi sa 4 preto�e DD je 4B ve�k�  
		inc edi 
		call CrLf
		jmp Nacitavanie
	

	Priprava:
	xor edi, edi						; edi sa nuluje k�li tomu �e sme ho pou��vali hore na na�itavanie
		lea ebx, poleCisel				; offset po�a pre nepriame adresovanie
		mov eax, [ebx + edi]			; eax bude obsahova� najmensie najdene cislo
		jmp Cyklus

	Cyklus:
		mov ecx, [ebx + (edi * 4)]		; poradov� cislo sa n�soby 4 preto lebo dd m� 4B
		cmp edi, dlzkaPola				; Overuje sa koniec po�a
		je Vystup
		cmp ecx, eax					; Porov�vaja �islo z pola ecx s doposia� najmen��m najden�m ��slom v eax
		jl Nasiel						;ak je men�ie ako doposial najdene tak ho nahrad�
		inc edi
		jmp Cyklus

	Nasiel:
		mov poradoveCislo, edi		; do premennej sa ulozi poradie najdeneho najmensieho cisla
		mov eax, ecx				; v eax sa nahradi predchadzaj�ce najmensie cislo aktu�lnym najmensim cislom
		inc edi
		jmp Cyklus

	Vystup:
		mov edx, offset najmeCisl	; V�pis hlasky
		call WriteString
		call WriteInt				; v eax je aktualne najmensie cislo ktor� sa vypise
		call Crlf
		mov edx, offset Vporadi
		call WriteString
		mov eax, poradoveCislo		; najmensie cislo sa nahradi poradovym cislom re vypis
		call WriteInt
		call Crlf
		exit
	
exit
main ENDP
END main

