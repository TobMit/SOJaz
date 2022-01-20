TITLE MASM Template(main.asm)
INCLUDE Irvine32.inc
.data

; ******************UPOZORNENIE********************
; *Spravy su sarkastyckÈ a nemyslenÈ vazne*
; *Tobi na sk˙ske si  skontroluj svoje komentare*
; *************************************************


dlzka equ 20
novaSprava DB dlzka + 1 dup(? ); neinicializovan· premenn·

Sprava BYTE "Assembler je velmi uzitocny program ktory urcite budem dennodene vyuzivat :D", 0Dh, 0Ah, 0; spr·va musÌ vzdy koncit nulov aby to ujo irvin vedel precitat, taktieû 0D a 0A hodi na novy riadok kurzor

.code
main PROC
	call Clrscr; VyËistenie s konzole


	xor edi, edi; index v poli
	xor ebx, ebx; poËÌtadlo kolko krat sa nachadza zadany znak v reùazci

	xor eax, eax
	call ReadChar; uklada zadany znak do AL

	mov ah, al;presuniem zadany znak z al do ah


	Vypis:
		mov	al, Sprava[edi]; priradenie jednÈho znaku z pola do al pre hladanie
		cmp al, 0
		je Koniec;
		cmp al, ah
		jne NieJeHladanyZnak
		inc edi; Zvyöenie indexu pola
		inc ebx;Zvyöenie poËnu najdenych prvokov
		jmp Vypis



	NieJeHladanyZnak:
		inc edi;Zvyöi index v poli
		jmp Vypis
	Koniec:
		mov eax, ebx
		call WriteInt

exit
main ENDP
END main

