TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data
velkost equ 15
precitanyString DB velkost + 1 dup(?)		;dup robí to že to nastaví a 0
;retazec BYTE "Assembly language program example",0

.code
main PROC
	call Clrscr
	mov edx, OFFSET precitanyString
	mov ecx, velkost
	call ReadString


	xor edi, edi  ;edi a esi sú indexové registre
	L1:
		mov al, precitanyString[edi]
		cmp al,0  ;porovna èi je koniec znaku (0 je stringu)
		jz L2
		inc edi
		call WriteChar  ;(èítal z al)
		inc al
		call WriteChar
		call Crlf
		jmp L1

	L2:

	exit
main ENDP

END main