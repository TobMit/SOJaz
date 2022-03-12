TITLE MASM Template(main.asm)
INCLUDE Irvine32.inc

; ----------Sekcia pre prototypy-------------------------------------------------------------------
Uloha1 proto, paOfsetMatica : dword, paPocetRiadkov : word, paDlzkaRiadku : word, paNazvy : dword, paNacitanaHodnota: word
Uloha2 proto, paOfsetMatica : dword, paPocetRiadkov : word, paDlzkaRiadku : word, paNazvy : dword
Uloha3 proto, paOfsetMatica : dword, paPocetRiadkov : word, paDlzkaRiadku : word, paNazvy : dword

.data
	Alex db "Alex ", 0
	Erik db "Erik ", 0
	Gustav db "Gustav ", 0
	Justin db "Justin ", 0
	Kris db "Kris ", 0
	Martin db "Martin ", 0
	Morgan db "Morgan ", 0
	Nick db "Nick ", 0
	Radko db "Radko ", 0
	Ryan db "Ryan " , 0



	nazvy dd  Alex, Erik, Gustav, Justin, Kris, Martin, Morgan, Nick, Radko, Ryan
	nazvyLenght db sizeof nazvy / type nazvy

;			pocOdo	pocKan
	Matica	DW 30,	21
			DW 36,	15
			DW 34,	19
			DW 33,	16
			DW 34,	33
			DW 37,	6
			DW 36,	31
			DW 38,	11
			DW 37,	10
			DW 36,	7


		


	dlzkaRaidku equ sizeof Matica

	uloha1testVstup DB "Zadajte parameter n: ",0
	uloha1texta DB "Vypiste, mena hracov, ktori dosiahli aspon ", 0
	uloha1textb DB " bodov : ",0Dh, 0Ah, 0
	uloha2text DB "Vypiste, pre kazdeho hraca priemerny pocet bodov na zapas: ", 0Dh, 0Ah, 0
	uloha3text DB "Vypiste, mena hracov, ktori dosiahli aspon 0,5 bodu na zapas: ", 0Dh, 0Ah, 0

.code

;-----------------------------------------------------------------------------------------------------------------------------------------

main PROC


	mov edx, offset uloha1testVstup
	call WriteString
	call ReadInt
	mov edx, offset uloha1texta
	call WriteString
	call WriteInt
	mov edx, offset uloha1textb
	call WriteString
	INVOKE Uloha1, offset Matica, nazvyLenght, dlzkaRaidku, offset nazvy, ax

	call Crlf
	call Crlf

	mov edx, offset uloha2text
	call WriteString
	INVOKE Uloha2, offset Matica, nazvyLenght, dlzkaRaidku, offset nazvy

	call Crlf

	mov edx, offset uloha3text
	call WriteString
	INVOKE Uloha3, offset Matica, nazvyLenght, dlzkaRaidku, offset nazvy


	exit
main ENDP

;---------------------------------------------------------------------------------------------------------------------------------------



Uloha1 proc USES eax ebx ecx edx esi edi, paOfsetMatica: dword, paPocetRiadkov : word, paDlzkaRiadku : word, paNazvy : dword, paNacitanaHodnota : word
.data
	pocetRiadkov equ paPocetRiadkov
	dlzkaRiadku equ paDlzkaRiadku
	pocetBodovNaVypis DW 0
.code
	xor edx, edx
	mov ax, paNacitanaHodnota
	mov dx, paNacitanaHodnota
	mov pocetBodovNaVypis, dx
	mov ebx, paOfsetMatica
	xor ecx, ecx	;pocitadlo cyklu
	xor edx, edx	;pouziva sa na vypis hracov
	xor esi, esi	;pocitadlo v matici
	xor edi, edi	;Pocitadlo v matici hracov
	mov cx, pocetRiadkov
	mov eax, paNazvy


	Cyklus :
		xor edx, edx
		mov dx, word ptr[ebx + esi + 1 * 2]		; do premennej sa ulozi hodnota na overovanie skore
		cmp pocetBodovNaVypis, dx
		ja Preskoc
		push eax
		mov al, 9
		call WriteChar
		pop eax
		mov edx, [eax + edi*4]
		call WriteString
		call Crlf
		Preskoc :
		add si, dlzkaRiadku
		inc edi
		loop Cyklus
	

	ret
Uloha1 ENDP

Uloha2 proc USES eax ebx ecx edx esi edi, paOfsetMatica: dword, paPocetRiadkov : word, paDlzkaRiadku : word, paNazvy : dword
.data
	pocetRiadkov equ paPocetRiadkov
	dlzkaRiadku equ paDlzkaRiadku
.code
	mov ebx, paOfsetMatica	; offset matice
	xor ecx, ecx
	xor esi, esi			; pocitadlo v matici
	xor edi, edi
	mov eax, paNazvy

	mov cx, pocetRiadkov		; obsahuje opakovanie

	Cyklus: 
		finit
		fild word ptr[ebx + esi + 1 * 2]		;pripoËÌta k registru st(0) hodnotu z integeru v mojom pripade je to vhodnÈ, keby chcem robyù sËÌtanie st(0) a st(1) tak by som dal fadd
		fild word ptr[ebx + esi + 0 * 2]
		fdiv
		mov edx, [eax + edi * 4]
		push eax
		mov al, 9
		call WriteChar
		pop eax
		call WriteString
		call writeFloat
		call Crlf
		add si, dlzkaRiadku
		inc di
		loop Cyklus

	ret
Uloha2 ENDP


Uloha3 proc USES eax ebx ecx edx esi edi, paOfsetMatica: dword, paPocetRiadkov : word, paDlzkaRiadku : word, paNazvy : dword
.data
	pocetRiadkov equ paPocetRiadkov
	dlzkaRiadku equ paDlzkaRiadku
	hodnotaNaPorovanie real10 0.5
.code
	mov ebx, paOfsetMatica; offset matice
	xor ecx, ecx
	xor esi, esi; pocitadlo v matici
	xor edi, edi
	mov eax, paNazvy

	mov cx, pocetRiadkov; obsahuje opakovanie

	Cyklus :
		finit
		fild word ptr[ebx + esi + 1 * 2]; pripoËÌta k registru st(0) hodnotu z integeru v mojom pripade je to vhodnÈ, keby chcem robyù sËÌtanie st(0) a st(1) tak by som dal fadd
		fild word ptr[ebx + esi + 0 * 2]
		fdiv
		fld hodnotaNaPorovanie
		fcompp
		push eax
		xor eax, eax
		fstsw ax
		sahf

		pop eax
		jnc Preskoc
		push eax
		mov al, 9
		call WriteChar
		pop eax
		mov edx, [eax + edi * 4]
		call WriteString
		call Crlf
		Preskoc:
		add si, dlzkaRiadku
		inc di
		loop Cyklus

	ret
Uloha3 ENDP

END main
