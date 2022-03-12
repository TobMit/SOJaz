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

; ------------------Procedura na Generovanie nahodn�ch cisel -------
Generuj PROC USES eax ebx ecx edx, paOffset:dword
	mov edx, paOffset
	mov esi, 0
	Generovanie:
		cmp esi,10
		je Pokracuj 
		mov eax, 32			; generuje n�hodn� �isla <0, 31>
		call RandomRange	; random pou��va na ohrani�enie register eax a v tom registri aj vracia n�hodn� ��slo
		call WriteInt
		call Crlf

		mov cl, al			; do cl pos�vame hodnotu preto, lebo sa v nom nach�dza n�hodn� ��slo ktor� vygeneroval randomRange
		xor ebx, ebx
		mov ebx, 1			; Vytvarame masku pre ��lo ktor� chcme ulo�i� v registry, masku pou��vame na to aby sme dostali jednoku do dan�ho bytu ktor� chceme zmeni� na 1
		shl ebx, cl			; pos�vame dan� byty o ��slo cl ktor� bolo generovan� n�hodne
		or [edx], ebx

		mov eax, 32; treba znovu nastavi� register eax aby sme mohli generova� znovu n�hodn� �islo
		inc esi
		jmp Generovanie

	Pokracuj: 
ret
Generuj ENDP


main PROC
	call Clrscr		; Vy�istenie s konzole
	Invoke Generuj, offset mnozina
	call Crlf
	mov ecx, 32
	VypisMnozinyLoop:
		rol mnozina, 1		; roluje dan� mno�inu do prava o 1 bit a ten ktor� a poda�a toho nastav� carry flag a bit vrati na koniec
		jnc  koniecVypisu	; testujem carry flag a ke� je pr�zdny tak preskakujeme vypis

		mov eax, ecx		; udaje o pozicii bytu z ecx presunieme do eax
		dec eax				;zn�ime o jedno aby sme sa dostali do <0,31>
		call WriteInt
		call Crlf

		koniecVypisu:

		loop VypisMnozinyLoop

exit
main ENDP
END main

