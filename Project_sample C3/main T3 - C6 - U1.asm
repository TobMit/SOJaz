TITLE MASM Template(main.asm)
INCLUDE Irvine32.inc
.data

dlzka equ 5

delitel DW 10
uvodnaVeta DB "Zadajte kladne alebo zaporne cislo", 0Dh, 0Ah,0

nacitaneCislo DB dlzka + 1 dup(0); neinicializovaná premenná
chybovaHlaska DB "Zadany zly vstup!!", 0Dh, 0Ah,0
UkoncovaciaHlaska DB "Program skonci zadanim 0.", 0Dh, 0Ah,0
ZnamienkoMinus DW 0
.code
main PROC
	call Clrscr; Vyèistenie s konzole
	jmp Start

	Start:
		xor eax, eax
		xor edi, edi
		xor ebx, ebx
		xor edx, edx
		xor ecx, ecx
		mov edx, offset uvodnaVeta
		call WriteString
		xor edx, edx

		call ReadInt
		cmp eax, 0
		je KoniecEx			; Ak je èíslo 0 tak program konèí
		jg Rozlozenie		; Ak je èislo kladané tak ho rozloží
		jl Doplnok			; Ak je èíslo záporné tak sa vypoèíta doplnok
	
	Doplnok:
		neg eax				; Premení záorné èislo na kladné
		; sub ebx, 1
		inc ZnamienkoMinus	; zmeni sa hodnota z 0 na 1 aby sa vedelo že sa spracováva záorne èislo
		call Rozlozenie

	Rozlozenie:
		idiv delitel; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!DIV a IDIV funguje iba keï je edx prázdny
		mov nacitaneCislo[edi], dl		;uloží zvyšok po delení do po¾a, dl je zvyšok po delení
		inc edi
		cmp eax, 0
		je Zlozenie
		xor edx,edx
		jmp Rozlozenie
	
	Zlozenie:
		mov cl, nacitaneCislo[ebx]		; z po¾a sa vyberie prvé èíslo
		add eax, ecx					; sèíta sa z finálnym èíslom
		cmp nacitaneCislo[ebx + 1], 0	; ešte pred násobením sa skontroluje èi náhodov nie je za tým nu¾a aby výsledné èislo nebolo o jednu desatinu väèšie
		je Vypis
		imul eax, 0Ah					;èíslo sa násobí 10
		inc ebx
		jmp Zlozenie

	Vypis:
		cmp ZnamienkoMinus, 1
		je VypisMinusovy
		call WriteInt
		jmp Koniec

	VypisMinusovy:
		neg eax			;kladné èíslo sa zneguje na záporné
		call WriteInt 
		jmp Koniec

	Koniec:
		call Crlf
		mov edx, offset UkoncovaciaHlaska
		call WriteString
		call Start
	
	KoniecEx:	
exit
main ENDP
END main

