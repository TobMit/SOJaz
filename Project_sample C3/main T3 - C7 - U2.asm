TITLE MASM Template(main.asm)
INCLUDE Irvine32.inc
.data

	uvodnaVeta DB "Zadajte kladne alebo zaporne cislo", 0Dh, 0Ah,0
	ano DB "ano", 0Dh, 0Ah,0
	nie DB "nie", 0Dh, 0Ah, 0

	poleCisel DB 0,4,8,-6,10,11,68,-54,21,0ffh

.code

main PROC
	call Clrscr; Vyèistenie s konzole
	call ReadInt

	xor edi, edi
	xor ecx, ecx
	lea ebx, poleCisel

	Cyklus:
		mov cl, [ebx + edi]
		cmp ecx, eax
		je Nasiel
		cmp cl, 0FFh
		je Nenasiel
		inc edi
		jmp Cyklus

	Nasiel:
		mov edx, offset ano
		call WriteString
		exit

	Nenasiel:
		mov edx, offset nie
		call WriteString
		exit
	
exit
main ENDP
END main

