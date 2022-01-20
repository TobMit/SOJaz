TITLE MASM Template(main.asm)
INCLUDE Irvine32.inc
.data

dlzka equ 5


nacitaneCislo DB dlzka + 1 dup(?); neinicializovan· premenn·
chybovaHlaska DB "Zadany zly vstup!!",0

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

		cmp bx , '0'
		jb ZlyVstup
		cmp bx, '9'
		ja ZlyVstup

		sub bx, 30h
		add ax, bx
		inc edi
		jmp Vypis


	ZlyVstup: 
		mov edx, offset chybovaHlaska
		call WriteString
		exit


	Koniec:
		call WriteInt
exit
main ENDP
END main

