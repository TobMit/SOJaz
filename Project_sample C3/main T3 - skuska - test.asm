TITLE MASM Template(main.asm)

; "Zadanie"
; "V subore VzdialenostiOkrMiest.csv su nazvy okresnych miest Zilinskeho kraja a matica vzdialenosti medzi nimi.
; "Ulozte udaje do vhodnej udajovej struktury.
; "Zistite, ktore mesto by malo byt krajskym mestom, ak chcete, aby to bolo centrum kraja, t.j.take mesto, z ktoreho najvacsia vzdialenost do ostatnych okresnych miest je najmensia.
; "Vypiste:
; "1. Pre kazde mesto najvacsiu vzdialenost z neho do ostatnych miest.
; "2. Pre kazde mesto jeho nazov, ako aj nazov k nemu najvzdialenejsieho mesta.
; "3. Nazov centralneho mesta.

include Irvine32.inc

; "Prototypy vsetkych pouzitych procedur"
OperacieSOkresmi proto, offsetPolaHodnot: dword, offsetPolaNazvov : dword
ExitProcess proto, dwExitCode : dword;


; "Konstanty

.386; "Definuje 32 bitovy program, ktory ma pristup k 32 bitovym registrom"
; .model flat, stdcall; "Zvoli pamatovy model flat a spristpupni volaciu metodu pre procedury - stdcall"
.stack 4096; "Uvolni pre aplikaciu 4096 bajtov pamate"

.data
	Bytca db "Bytca", 0
	Cadca db "Cadca", 0
	DolnyKubin db "Dolny Kubin", 0
	KysNovMesto db "Kysucke Nove Mesto", 0
	LipMikulas db "Liptovsky Mikulas", 0
	Martin db "Martin", 0
	Namestovo db "Namestovo", 0
	Ruzomberok db "Ruzomberok", 0
	Tvrdosin db "Tvrdosin", 0
	TurTeplice db "Turcianske Teplice", 0
	Zilina db "Zilina", 0

	task1Message db "Najvacsia vzdialenost do kazdeho mesta", 0
	task2Message db "Centralne mesto", 0

	nazvy dd Bytca, Cadca, DolnyKubin, KysNovMesto, LipMikulas, Martin, Namestovo, Ruzomberok, TurTeplice, Tvrdosin, Zilina
	hodnoty  dd 0, 46, 81, 26, 108, 49, 100, 82, 72, 112, 20
	dd	46, 0, 67, 21, 111, 60, 69, 85, 84, 81, 34
	dd	81, 67, 0, 61, 43, 43, 32, 18, 68, 31, 53
	dd	26, 21, 61, 0, 97, 40, 75, 73, 63, 88, 12
	dd 108, 111, 43, 97, 0, 70, 69, 27, 94, 55, 88
	dd	49, 60, 43, 40, 70, 0, 74, 44, 24, 73, 30
	dd	100, 69, 32, 75, 69, 74, 0, 49, 99, 14, 79
	dd	82, 85, 18, 73, 27, 44, 49, 0, 68, 48, 63
	dd	72, 84, 68, 63, 94, 24, 99, 68, 0, 98, 53
	dd	112, 81, 31, 88, 55, 73, 14, 48, 98, 0, 92
	dd	20, 34, 53, 12, 88, 30, 79, 63, 53, 92, 0

	pocetPrvkov equ lengthof hodnoty; "Pocet riadkov v matici"
	pocetMiest equ sizeof nazvy / type nazvy; "Pocet stlpcov v matici"
	pocetMiest2 dd sizeof nazvy / type nazvy


.code
main PROC
	finit; "Inicializacia FPU procesora"

	invoke OperacieSOkresmi, offset hodnoty, offset nazvy

	invoke ExitProcess, 0
main ENDP


; "---------------------------------------------------------------------------------------------"
OperacieSOkresmi proc uses eax ebx ecx edx esi edi offsetPolaHodnot : dword, offsetPolaNazvov : dword
; "Funkcia ktora z nacitanych dat vypise okresy, ktore maju nad 50 000 obyvatelov"
; "Vstup - poleHodnot: pole, kde sa nachadzaju hodnoty o danych mestach, poleNazvov: pole, kde sa nachadzaju nazvy miest"
; "Vystup"
; "---------------------------------------------------------------------------------------------"
.data
	dvojbodka db ": ", 0
	cityMaxValueIndex dd 0; "Index mesta s najvacsou vzdialenostou"
	centralCityIndex dd 0; "Index centralneho mesta"
	centralCityValue dd 0
	cityDistances dd 11 dup(? )
.code
	mov ebx, offsetPolaNazvov
	mov edx, offsetPolaHodnot

	push edx
	mov edx, offset task1Message
	call WriteString
	call Crlf
	pop edx

	; "Vypis najvacsej vzdialenosti z kazdeho mesta
	mov ecx, pocetMiest
	xor esi, esi
	xor edi, edi
	MainLoop :
		push ecx
		mov ecx, pocetPrvkov

		push edx

		mov edx, [ebx + edi * 4]
		call WriteString

		mov edx, offset dvojbodka
		call WriteString
		pop edx

		push ebx
		mov ebx, 0

		push edi
		mov edi, 0
		NajdiNajvacsiuVzdialenost:
				mov eax, [edx + esi * 4]
				cmp eax, ebx
				jg VacsiPrvok
				jmp Pokracuj
			VacsiPrvok :
				mov ebx, eax
				mov cityMaxValueIndex, edi
			Pokracuj :
				inc esi
				inc edi
			loop NajdiNajvacsiuVzdialenost
		; "Vypis najvacsej vzdialenosti"
		mov eax, ebx
		call WriteInt

		pop edi
		pop ebx

		; "Vypis nazvu mesta s najvacsou vzdialenostou"
		push edx
		mov eax, cityMaxValueIndex
		mov edx, [ebx + eax * 4]
		call WriteString

		call Crlf
		pop edx
		inc edi
		pop ecx
		loop MainLoop



	push edx
	call Crlf
	mov edx, offset task2Message
	call WriteString
	call crlf
	pop edx

	; "Vypocet vzdialenosti miest od vsetkych miest"
	mov ecx, pocetMiest
	xor esi, esi
	xor edi, edi
	MainLoop2 :
		push ecx
		mov ecx, pocetPrvkov

		mov ebx, 0
		CelkovaVzdialenost :
			mov eax, [edx + esi * 4]
			add ebx, eax
			inc esi
			loop CelkovaVzdialenost
			push edx
			mov edx, offset cityDistances
			mov[edx + edi * 4], ebx
			pop edx
			inc edi
			pop ecx
			loop MainLoop2


		; "Zistenie centralneho mesta"

		mov ecx, pocetMiest
		dec ecx
		xor esi, esi
		xor edi, edi
		mov edx, offset cityDistances
		mov centralCityValue, edx
		MainLoop3 :
			mov eax, [edx + esi * 4]
			cmp eax, centralCityValue
			jb MensiaHodnota
			jmp Pokracuj2
			MensiaHodnota :
			mov centralCityValue, eax
			mov centralCityIndex, esi
			Pokracuj2 :
			inc esi
			loop MainLoop3

	mov ebx, offsetPolaNazvov

	mov eax, centralCityIndex
	mov edx, [ebx + eax * 4]
	call WriteString
	mov eax, centralCityValue
	call WriteInt
	ukonciProceduru :
	ret
OperacieSOkresmi endp

END main