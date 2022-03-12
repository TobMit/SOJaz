TITLE MASM Template(main.asm)
INCLUDE Irvine32.inc
.data

dlzkaPola equ 10

najmeCisl DB "Najmensie cislo je: ", 0
Vporadi DB "V poradi (cisluje sa od 0): ", 0
Uvod DB "Nacitajte cisla do pola!", 0Dh, 0Ah, 0

poleCisel DD dlzkaPola dup(0)
poradoveCislo DD 0

mnozina DD 0

.code

; ------------------Procedura na Generovanie nahodnıch cisel -------
Generuj PROC USES eax ebx ecx edx, paOffset:dword
	mov edx, paOffset
	mov esi, 0
	Generovanie:
		cmp esi,10
		je Pokracuj 
		mov eax, 32			; generuje náhodné èisla <0, 31>
		call RandomRange	; random pouíva na ohranièenie register eax a v tom registri aj vracia náhodné èíslo
		call WriteInt
		call Crlf

		mov cl, al			; do cl posúvame hodnotu preto, lebo sa v nom nachádza náhodné èíslo ktoré vygeneroval randomRange
		xor ebx, ebx
		mov ebx, 1			; Vytvarame masku pre èílo ktoré chcme uloi v registry, masku pouívame na to aby sme dostali jednoku do daného bytu ktorı chceme zmeni na 1
		shl ebx, cl			; posúvame dané byty o èíslo cl ktoré bolo generované náhodne
		or [edx], ebx

		mov eax, 32; treba znovu nastavi register eax aby sme mohli generova znovu náhodné èislo
		inc esi
		jmp Generovanie

	Pokracuj: 
ret
Generuj ENDP


main PROC
	call Clrscr		; Vyèistenie s konzole
	Invoke Generuj, offset mnozina
	call Crlf
	mov ecx, 32
	VypisMnozinyLoop:
		rol mnozina, 1		; roluje danú mnoinu do prava o 1 bit a ten ktorı a poda¾a toho nastaví carry flag a bit vrati na koniec
		jnc  koniecVypisu	; testujem carry flag a keï je prázdny tak preskakujeme vypis

		mov eax, ecx		; udaje o pozicii bytu z ecx presunieme do eax
		dec eax				;zníime o jedno aby sme sa dostali do <0,31>
		call WriteInt
		call Crlf

		koniecVypisu:

		loop VypisMnozinyLoop

exit
main ENDP
END main

