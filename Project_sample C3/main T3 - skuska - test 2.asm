TITLE MASM Template(main.asm)
INCLUDE Irvine32.inc

; ----------Sekcia pre prototypy-------------------------------------------------------------------
Uloha1 proto, paOfsetMatica : dword, paPocetRiadkov : word, paDlzkaRiadku : word, paNazvy : dword
Uloha2 proto, paOfsetMatica : dword, paPocetRiadkov : word, paDlzkaRiadku : word, paNazvy : dword
Uloha3 proto, paOfsetMatica : dword, paPocetRiadkov : word, paDlzkaRiadku : word, paNazvy : dword

.data
	Alex db "Alex ", 0
	Elias db "Elias ", 0
	Gabriel db "Gabriel ", 0
	Jonathan db "Jonathan ", 0
	Marcus db "Marcus ", 0
	Mats db "Mats ", 0
	Mikko db "Mikko ", 0
	Paul db "Paul ", 0
	Ryan db "Ryan ", 0
	Sam db "Sam " , 0



	nazvy dd  Alex, Elias, Gabriel, Jonathan, Marcus, Mats, Mikko, Paul, Ryan, Sam
	nazvyLenght db sizeof nazvy / type nazvy

;			pocKab	striel	gol
	Matica	DW 54,	181,	26
			DW 29,	95,		12
			DW 36,	80,		14
			DW 53,	102,	15
			DW 23,	50,		14
			DW 30,	66,		11
			DW 44,	112,	19
			DW 16,	36,		8
			DW 30,	115,	16
			DW 23,	107,	15

		


	dlzkaRaidku equ sizeof Matica; vr·ti dlzku jednÈho riadku v mojom prÌpade je to 12 pretoûe pouûÌwam dword

	uloha1text DB "Vypiste, meno hraca s najvyssim poctom kanadskych bodov: ", 0
	uloha2text DB "Vypocitajte percentualnu upesnost strelby kazdeho hraca: ", 0Dh, 0Ah, 0
	uloha3text DB "Vypiste meno hraca s navyssou percentualnou uspesnostou streby: ", 0

.code

;-----------------------------------------------------------------------------------------------------------------------------------------

main PROC
	; IndexRiadku equ 0
	; IndexStlpca equ 0

	; mov ebx, dlzkaRaidku* IndexRiadku; dlûka sa nasobÌ ËÌslom riadku pre to aby sme dostali adresu v pameti
	; v pameti s˙ uloûenÈ inform·cie v matici za sebou, tak preto sa nasobÌ öÌrk matice s riadkom
	; mov esi, indexStlpca
	; mov ax, Matica[ebx + esi * type Matica]; je povinnosù vûdy vynasobyù index stlpca s type Matica
	; call WriteInt


	finit


	mov edx, offset uloha1text
	call WriteString
	INVOKE Uloha1, offset Matica, nazvyLenght, dlzkaRaidku, offset nazvy

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



Uloha1 proc USES eax ebx ecx edx esi edi, paOfsetMatica: dword, paPocetRiadkov : word, paDlzkaRiadku : word, paNazvy : dword
.data
	pocetRiadkov equ paPocetRiadkov
	dlzkaRiadku equ paDlzkaRiadku
	indexHracaSNajviacBodmi DW ?
.code
	mov ebx, paOfsetMatica
	xor ecx, ecx	;pocitadlo cyklu
	xor edx, edx	;pouziva sa na vypis miest
	xor esi, esi	;pocitadlo v matici
	xor edi, edi	;Pocitadlo v matici miest
	mov cx, pocetRiadkov
	mov eax, paNazvy

	mov indexHracaSNajviacBodmi, 0

	Cyklus :
	push ecx
		mov cx, indexHracaSNajviacBodmi
		imul cx, dlzkaRiadku
		push eax
		push edx
		xor eax, eax
		xor edx, edx
		mov ax, word ptr[ebx + ecx + 0 * 2]		; do premennej sa ulozi hodnota na overovanie skore
		mov dx, word ptr[ebx + esi + 0 * 2]		; do premennej sa ulozi hodnota na overovanie skore
		cmp eax, edx
		pop edx
		pop eax
		pop ecx
		ja Preskoc
		mov indexHracaSNajviacBodmi, di
		Preskoc :
		add si, dlzkaRiadku
		inc edi
		loop Cyklus
	
	xor ebx, ebx
	mov bx, indexHracaSNajviacBodmi
	mov edx, [eax + ebx*4]
	call WriteString

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
		fild word ptr[ebx + esi + 2 * 2]		;pripoËÌta k registru st(0) hodnotu z integeru v mojom pripade je to vhodnÈ, keby chcem robyù sËÌtanie st(0) a st(1) tak by som dal fadd
		fild word ptr[ebx + esi + 1 * 2]
		fdiv
		mov edx, [eax + edi * 4]
		call WriteString
		call writeFloat
		call Crlf
		add si, dlzkaRiadku
		inc di
		;fcompp									; okrem inÈho aj premaz·va prv· dva fpu registre, a plus porovn·va ich a nastavuje bity ale to je teraz vedlajöie
		loop Cyklus

	ret
Uloha2 ENDP


Uloha3 proc USES eax ebx ecx edx esi edi, paOfsetMatica: dword, paPocetRiadkov : word, paDlzkaRiadku : word, paNazvy : dword
.data
	pocetRiadkov equ paPocetRiadkov
	dlzkaRiadku equ paDlzkaRiadku
	indexHraca dw 0
	priemerHraca real10 ?
	priemerHracaOdlozenie real10 ?
.code
	mov ebx, paOfsetMatica; offset matice
	xor ecx, ecx
	xor esi, esi; pocitadlo v matici
	xor edi, edi;pocitadlo poradia
	mov eax, paNazvy

	mov cx, pocetRiadkov; obsahuje opakovanie

	fild word ptr[ebx + esi + 2 * 2]		; pripoËÌta k registru st(0) hodnotu z integeru v mojom pripade je to vhodnÈ, keby chcem robyù sËÌtanie st(0) a st(1) tak by som dal fadd
	fild word ptr[ebx + esi + 1 * 2]
	fdiv
	fstp priemerHraca

	Cyklus :
		fild word ptr[ebx + esi + 2 * 2]	; pripoËÌta k registru st(0) hodnotu z integeru v mojom pripade je to vhodnÈ, keby chcem robyù sËÌtanie st(0) a st(1) tak by som dal fadd
		fild word ptr[ebx + esi + 1 * 2]
		fdiv
		fstp priemerHracaOdlozenie	; odlozÌ sa do lokalnej premennej
		fld priemerHraca			; vlozi sa hrac z najvyssim skore
		fld priemerHracaOdlozenie	; vlozi sa skore ktorÈ sa porvnava
		push eax
		fcompp			; porovnaj˙ sa hodnoty a vymazu sa
		xor eax, eax
		fnstsw ax		; hodnoty c sa presun˙ do registra ax
		sahf			; podla registra ah sa nastavia flags
		jb Skok

		mov indexHraca, di
		fld priemerHracaOdlozenie		; do pamete sa naspet vr·ti priemer hraca ktor˝ sa pri fcompp vymazal
		fstp priemerHraca				;priemer hraca sa ulozi pre dalsie porovanie
		Skok:
		add si, dlzkaRiadku
		inc di
		pop eax
		loop Cyklus

	mov cx, indexHraca
	imul ecx, 4
	mov edx, [eax + ecx]
	call WriteString

	ret
Uloha3 ENDP

END main
