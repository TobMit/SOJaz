TITLE MASM Template(main.asm)
INCLUDE Irvine32.inc
.data

	dlzka equ 6

	delitel DW 10
	uvodnaVeta DB "Zadajte kladne alebo zaporne cislo", 0Dh, 0Ah,0

	nacitaneCislo DB dlzka + 1 dup(0Ah); neinicializovaná premenná
	chybovaHlaska DB "Zadany zly vstup!!", 0Dh, 0Ah,0
	UkoncovaciaHlaska DB "Program skonci zadanim 0.", 0Dh, 0Ah,0



.code

StringToInt PROC USES eax edx ecx edi, paStringVstup: dword, paVelskostCisla: word
LOCAL ZnamienkoMinus: word

mov ZnamienkoMinus, 0
	xor edi, edi

	mov edx, paStringVstup
	xor eax, eax
	jmp Spracovanie
	
	Spracovanie:
		mov cl, nacitaneCislo[edi]		; z po¾a sa vyberie prvé èíslo

		cmp nacitaneCislo[edi+1], 0Ah
		je Vypis
		cmp cl, '-'
		je Minus
		cmp cl, '+'
		je plus
		inc edi

		and cl, 0fh 
		add eax, ecx					; sèíta sa z finálnym èíslom	
		cmp di, paVelskostCisla
		je Vypis
		imul eax, 0Ah					;èíslo sa násobí 10
		jmp Spracovanie

	Minus:
		inc ZnamienkoMinus
		inc edi
		call Spracovanie

	Plus:
		inc edi
		call Spracovanie

	SpracujMinus:
		dec ZnamienkoMinus
		neg eax
		call Vypis

	Vypis:
		cmp ZnamienkoMinus, 1
		je SpracujMinus
		call WriteInt
		jmp Koniec

	Koniec:
ret
StringToInt ENDP


main PROC
	call Clrscr; Vyèistenie s konzole
	mov edx, offset nacitaneCislo
	mov ecx, dlzka
	call ReadString
	INVOKE StringToInt, edx, ax
	
exit
main ENDP
END main

