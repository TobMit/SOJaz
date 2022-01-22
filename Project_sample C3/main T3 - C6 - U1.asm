TITLE MASM Template(main.asm)
INCLUDE Irvine32.inc
.data

dlzka equ 5

delitel DW 10
uvodnaVeta DB "Zadajte kladne alebo zaporne cislo", 0Dh, 0Ah,0

nacitaneCislo DB dlzka + 1 dup(0); neinicializovan� premenn�
chybovaHlaska DB "Zadany zly vstup!!", 0Dh, 0Ah,0
UkoncovaciaHlaska DB "Program skonci zadanim 0.", 0Dh, 0Ah,0
ZnamienkoMinus DW 0
.code
main PROC
	call Clrscr; Vy�istenie s konzole
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
		je KoniecEx			; Ak je ��slo 0 tak program kon��
		jg Rozlozenie		; Ak je �islo kladan� tak ho rozlo��
		jl Doplnok			; Ak je ��slo z�porn� tak sa vypo��ta doplnok
	
	Doplnok:
		neg eax				; Premen� z�orn� �islo na kladn�
		; sub ebx, 1
		inc ZnamienkoMinus	; zmeni sa hodnota z 0 na 1 aby sa vedelo �e sa spracov�va z�orne �islo
		call Rozlozenie

	Rozlozenie:
		idiv delitel; !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!DIV a IDIV funguje iba ke� je edx pr�zdny
		mov nacitaneCislo[edi], dl		;ulo�� zvy�ok po delen� do po�a, dl je zvy�ok po delen�
		inc edi
		cmp eax, 0
		je Zlozenie
		xor edx,edx
		jmp Rozlozenie
	
	Zlozenie:
		mov cl, nacitaneCislo[ebx]		; z po�a sa vyberie prv� ��slo
		add eax, ecx					; s��ta sa z fin�lnym ��slom
		cmp nacitaneCislo[ebx + 1], 0	; e�te pred n�soben�m sa skontroluje �i n�hodov nie je za t�m nu�a aby v�sledn� �islo nebolo o jednu desatinu v��ie
		je Vypis
		imul eax, 0Ah					;��slo sa n�sob� 10
		inc ebx
		jmp Zlozenie

	Vypis:
		cmp ZnamienkoMinus, 1
		je VypisMinusovy
		call WriteInt
		jmp Koniec

	VypisMinusovy:
		neg eax			;kladn� ��slo sa zneguje na z�porn�
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

