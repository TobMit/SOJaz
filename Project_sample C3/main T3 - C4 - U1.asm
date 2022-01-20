TITLE MASM Template(main.asm)
INCLUDE Irvine32.inc
.data

; ******************UPOZORNENIE********************
; *Spravy su sarkastyck� a nemyslen� vazne*
; *Tobi na sk�ske si  skontroluj svoje komentare*
; *************************************************


dlzka equ 20
Velkost equ 50

novaSprava DB dlzka + 1 dup(? ); neinicializovan� premenn�

Sprava BYTE "Assembler je velmi uzitocny program ktory urcite budem dennodene vyuzivat :D", 0Dh, 0Ah, 0; spr�va mus� vzdy koncit nulov aby to ujo irvin vedel precitat, taktie� 0D a 0A hodi na novy riadok kurzor
RetazecR DB "Ucim sa programova� v assemblery sD", 0Dh, 0Ah, 0
RetazecS DB Velkost + 1 dup(?)

.code
main PROC
	call Clrscr; Vy�istenie s konzole


	xor edi, edi; index v poli RetazecR
	xor ebx, ebx; index v poli RetazecS



	Vypis:
		mov	al, RetazecR[edi]; priradenie jedn�ho znaku z pola do al pre hladanie
		cmp al, 0
		je Koniec;

		cmp al, 'a'
		jne NieJeHladanyZnak

		mov ah, RetazecR[edi + 1]
		cmp ah, 's'
		je UrobCenzuru

		jmp NieJeHladanyZnak



	NieJeHladanyZnak:
		mov RetazecS[ebx], al
		inc edi; Zvy�i index v poli
		inc ebx;Zvy�i index v poli S
		jmp Vypis

	UrobCenzuru:
		mov RetazecS[ebx], '*'
		inc edi; Zvy�i index v poli R
		inc edi; Zvy�i index v poli R - preto lebo sme u� na��tali aj ten dal�� znak a preto ho potrebujeme presko�i�
		inc ebx; Zvy�i index v poli S
		jmp Vypis

	Koniec:
		mov RetazecS[ebx], al
		mov edx, OFFSET RetazecS
		mov ecx, Velkost
		call WriteString

exit
main ENDP
END main

