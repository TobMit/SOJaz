TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data
retazec BYTE "Assembly language program example",0

.code
main PROC
	call Clrscr
	xor edi, edi  ;edi a esi s� indexov� registre
	L1:
		mov al, retazec[edi]
		cmp al,0  ;porovna �i je koniec znaku (0 je stringu)
		je L2
		inc edi
		call WriteChar  ;(��tal z al)
		call Crlf
		jmp L1

	L2:

	exit
main ENDP

END main