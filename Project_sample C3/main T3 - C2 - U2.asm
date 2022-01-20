TITLE MASM Template(main.asm)
INCLUDE Irvine32.inc
.data
dlzka equ 20
novaSprava DB dlzka + 1 dup(? ); neinicializovan· premenn·
.code
main PROC
	call Clrscr; VyËistenie s konzole

	mov edx, offset novaSprava
	mov ecx, dlzka

	call ReadString; ReadString potrebuje maù offset v edx a velkost nacitavania je v ecx

	xor edi, edi ;poËÌtanie premennej

	Vypis:
		mov	al, novaSprava[edi]; priradenie jednÈho znaku z pola do al pre WriteChar
		cmp al, 0
		je Koniec
		call WriteChar
		inc edi
		call Crlf; Nov˝ riadok
		jmp Vypis



	Koniec:

exit
main ENDP
END main

