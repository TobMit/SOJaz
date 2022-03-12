TITLE MASM Template(main.asm)
INCLUDE Irvine32.inc

; ----------Sekcia pre prototypy-------------------------------------------------------------------
Uloha1 proto, paOfsetMatica: dword, paPocetRiadkov : word, paDlzkaRiadku : word
Uloha2 proto, paOfsetMatica : dword, paPocetRiadkov : word, paDlzkaRiadku : word, paNazvy : dword
Uloha3 proto, paOfsetMatica : dword, paPocetRiadkov : word, paDlzkaRiadku : word
Uloha4 proto, paOfsetMatica : dword, paPocetRiadkov : word, paDlzkaRiadku : word, paNazvy : dword

.data
	Bytca db "Bytca", 0
	Cadca db "Cadca", 0
	DolnyKubin db "Dolny Kubin", 0
	KysuckeNoveMesto db "Kysucke Nove Mesto", 0
	LiptovskyMikulas db "Liptovsky Mikulas", 0
	Martin db "Martin", 0
	Namestovo db "Namestovo", 0
	Ruzomberok db "Ruzomberok", 0
	TurcianskeTeplice db "Turcianske Teplice", 0
	Tvrdosin db "Tvrdosin", 0
	Zilina db "Zilina", 0


	nazvy dd  Bytca, Cadca, DolnyKubin, KysuckeNoveMesto, LiptovskyMikulas, Martin, Namestovo, Ruzomberok, TurcianskeTeplice, Tvrdosin, Zilina
	nazvyLenght db sizeof nazvy / type nazvy

;			poc obyv	rozlh	poc obci
	Matica	DD 30712,	282,	11
			DD 90850,	761,	20
			DD 39494,	490,	23
			DD 33075,	174,	13
			DD 72451,	1341,	54
			DD 96742,	736,	40
			DD 61526,	691,	23
			DD 57044,	647,	24
			DD 16070,	393,	25
			DD 36024,	479,	13
			DD 156618,	815,	50


	dlzkaRaidku equ sizeof Matica; vr·ti dlzku jednÈho riadku v mojom prÌpade je to 12 pretoûe pouûÌwam dword

	uloha1text DB "Vypiste, kolko okresov ma menej nez 50 000 obyvatelov: ", 0
	uloha2text DB "Vypiste nazvy okresov, ktore maju menej nez 50 000 obyvatelov:", 0Dh, 0Ah, 0
	uloha3text DB "Vypocitajte priemerny pocet obyvatelov okresu: ", 0
	uloha4text DB "Vypiste nazvy okresov, ktore maju nadpriemerny pocet obyvatelov:", 0Dh, 0Ah, 0

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
	INVOKE Uloha1, offset Matica, nazvyLenght, dlzkaRaidku
	call WriteInt

	call Crlf
	call Crlf

	mov edx, offset uloha2text
	call WriteString
	INVOKE Uloha2, offset Matica, nazvyLenght, dlzkaRaidku, offset nazvy

	call Crlf

	mov edx, offset uloha3text
	call WriteString
	INVOKE Uloha3, offset Matica, nazvyLenght, dlzkaRaidku

	call Crlf
	call Crlf

	mov edx, offset uloha4text
	call WriteString
	INVOKE Uloha4, offset Matica, nazvyLenght, dlzkaRaidku, offset nazvy


	exit
main ENDP

;---------------------------------------------------------------------------------------------------------------------------------------

Uloha1 proc USES ebx ecx edx esi edi, paOfsetMatica: dword, paPocetRiadkov : word, paDlzkaRiadku : word
; Proced˙ra vr·ti pocet ludÌ v registry eax
.data
	pocetRiadkov equ paPocetRiadkov
	dlzkaRiadku equ paDlzkaRiadku
.code
	mov ebx, paOfsetMatica;offset matice
	xor eax, eax				; vrati sa pocet miest 
	xor ecx, ecx
	xor edx, edx				;pouzi va sa na overenie
	xor esi, esi				;pocitadlo v matici
	mov cx, pocetRiadkov		;obsahuje opakovanie

	Cyklus:
		mov edx, dword ptr[ebx + esi + 0 * 4]
		cmp edx, 50000
		ja Preskoc
		inc eax
		Preskoc:
		add si, dlzkaRiadku
		loop Cyklus
	

	ret
Uloha1 ENDP


Uloha2 proc USES eax ebx ecx edx esi edi, paOfsetMatica: dword, paPocetRiadkov : word, paDlzkaRiadku : word, paNazvy : dword
.data
	pocetRiadkov equ paPocetRiadkov
	dlzkaRiadku equ paDlzkaRiadku
.code
	mov ebx, paOfsetMatica
	xor ecx, ecx	;pocitadlo cyklu
	xor edx, edx	;pouziva sa na vypis miest
	xor esi, esi	;pocitadlo v matici
	xor edi, edi	;Pocitadlo v matici miest
	mov cx, pocetRiadkov
	mov eax, paNazvy



	Cyklus :
		push ecx
		mov ecx, dword ptr[ebx + esi + 0 * 4]
		cmp ecx, 50000
		pop ecx
		ja Preskoc
		mov edx, dword ptr [eax + edi * 4]
		call WriteString
		call Crlf
		Preskoc :
		add si, dlzkaRiadku
		inc edi
		loop Cyklus


	ret
Uloha2 ENDP

Uloha3 proc USES eax ebx ecx edx esi edi, paOfsetMatica: dword, paPocetRiadkov : word, paDlzkaRiadku : word
.data
	pocetRiadkov equ paPocetRiadkov
	dlzkaRiadku equ paDlzkaRiadku
.code
	mov ebx, paOfsetMatica	; offset matice
	xor ecx, ecx
	xor esi, esi			; pocitadlo v matici

	mov cx, pocetRiadkov		; obsahuje opakovanie
	dec ecx						;Zniûim hodnotu kÙli tomu ûe prvÈ zaradenie z matice robÌm mimo cykla, preto potrebujem aby to prebehlo menej kr·t
	fild dword ptr[ebx + esi]	;sa hodnota musÌ nahodiù manu·lne lebo inak mi pripoËÌtavanie v cykle nebude fungovaù - to je featchura assembleru
	add si, dlzkaRiadku			;prid· sa öÌrka riadku do poradia aby som vyberal vûdy iba prv˝ prvok z kaûdÈho riadku

	Cyklus:
		fiadd dword ptr[ebx + esi]		;pripoËÌta k registru st(0) hodnotu z integeru v mojom pripade je to vhodnÈ, keby chcem robyù sËÌtanie st(0) a st(1) tak by som dal fadd
		add si, dlzkaRiadku
		loop Cyklus

	fild pocetRiadkov		;do st(0) sa musÌ eöte pridaù aj poËet miest aby som vedel spraviù priemer
	fdivp st(1), st(0)		;musia sa deliù otoËene lebo, v st(1) je ˙daj o celkov˝ch obyvateæoch a v st(0) je zase poËet miest
	call WriteFloat

	ret
Uloha3 ENDP


Uloha4 proc USES eax ebx ecx edx esi edi, paOfsetMatica: dword, paPocetRiadkov : word, paDlzkaRiadku : word, paNazvy : dword
.data
	pocetRiadkov equ paPocetRiadkov
	dlzkaRiadku equ paDlzkaRiadku
.code
	mov ebx, paOfsetMatica; offset matice
	xor ecx, ecx
	xor esi, esi		; pocitadlo v matici


	mov cx, pocetRiadkov		; obsahuje opakovanie
	dec ecx						; Zniûim hodnotu kÙli tomu ûe prvÈ zaradenie z matice robÌm mimo cykla, preto potrebujem aby to prebehlo menej kr·t
	fild dword ptr[ebx + esi]	; sa hodnota musÌ nahodiù manu·lne lebo inak mi pripoËÌtavanie v cykle nebude fungovaù - to je featchura assembleru
	add si, dlzkaRiadku			; prid· sa öÌrka riadku do poradia aby som vyberal vûdy iba prv˝ prvok z kaûdÈho riadku

	Cyklus :
		fiadd dword ptr[ebx + esi]		; pripoËÌta k registru st(0) hodnotu z integeru v mojom pripade je to vhodnÈ, keby chcem robyù sËÌtanie st(0) a st(1) tak by som dal fadd
		add si, dlzkaRiadku
		loop Cyklus

	fild pocetRiadkov		; do st(0) sa musÌ eöte pridaù aj poËet miest aby som vedel spraviù priemer
	fdivp st(1), st(0)		; musia sa deliù otoËene lebo, v st(1) je ˙daj o celkov˝ch obyvateæoch a v st(0) je zase poËet miest

	mov cx, pocetRiadkov
	xor esi, esi
	xor edi, edi

	CyklusDva:
		
		ficom dword ptr[ebx + esi]	; porovna hodnotu v st(0) s to u ktor· je v matici a nastavy prisluËne c flagy
		fnstsw ax					; skopÌruje flagy do registra ax
		sahf						; nastavi pomocou registra ah klasickÈ flagy
		jae Skok					;pomocou nastaven˝ch flagou sa robia riadene skoky
		push ebx
		mov ebx, paNazvy
		mov edx, dword ptr[ebx + edi * 4]
		call WriteString
		call Crlf
		pop ebx 

		Skok:
		add si, dlzkaRiadku
		inc edi
		loop CyklusDva

	ret
Uloha4 ENDP

END main
