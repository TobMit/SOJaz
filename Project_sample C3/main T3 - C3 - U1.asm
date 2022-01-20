TITLE MASM Template(main.asm)
INCLUDE Irvine32.inc
.data

;******************UPOZORNENIE********************
;*   Spravy su sarkastyckÈ a nemyslenÈ vazne     *
;* Tobi na sk˙ske si  skontroluj svoje komentare *
;*************************************************


dlzka equ 20
novaSprava DB dlzka + 1 dup(? ); neinicializovan· premenn·

Sprava BYTE "Assembler je velmi uzitocny program ktory urcite budem dennodene vyuzivat :D", 0;spr·va musÌ vzdy koncit nulov aby to ujo irvin vedel precitat

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
		inc al
		call WriteChar
		inc edi
		call Crlf; Nov˝ riadok
		jmp Vypis



	Koniec:

exit
main ENDP
END main

