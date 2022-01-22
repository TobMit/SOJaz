TITLE MASM Template(main.asm)
INCLUDE Irvine32.inc
.data

dlzka equ 5


nacitaneCislo DB dlzka + 1 dup(?); neinicializovan· premenn·
chybovaHlaska DB "Zadany zly vstup!!",0
ZnamienkoMinus DW 0
.code
main PROC
	call Clrscr; VyËistenie s konzole

	mov edx, offset nacitaneCislo
	mov ecx, dlzka

	call ReadString; ReadString potrebuje maù offset v edx a velkost nacitavania je v ecx

	xor edi, edi ;index pola nacitaneCislo
	xor eax, eax
	xor ebx, ebx

	Vypis:
		mov	bl, nacitaneCislo[edi]; priradenie jednÈho znaku z pola do al pre WriteChar
		cmp bx, 0
		je Koniec

		cmp bx, '-'
		je ZaporneCislo
		cmp bx, '+'
		je KladneCislo
		cmp bx , '0'
		jb ZlyVstup
		cmp bx, '9'
		ja ZlyVstup

		sub bx, 30h
		add ax, bx
		inc edi
		jmp Vypis

	KladneCislo:
		inc edi
		call Vypis

	ZaporneCislo:
		mov ZnamienkoMinus, 1
		inc edi
		jmp Vypis

	ZlyVstup: 
		mov edx, offset chybovaHlaska
		call WriteString
		exit


	KoniecZMinusom:
		imul eax, -1
		call WriteInt
		exit


	Koniec:
		cmp ZnamienkoMinus, 1
		je KoniecZMinusom
		call WriteInt
exit
main ENDP
END main

