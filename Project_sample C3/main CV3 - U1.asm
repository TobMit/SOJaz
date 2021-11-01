TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data
myMessage BYTE "Assembly language program example",0

.code
main PROC
	call Clrscr

	mov	 edx,OFFSET myMessage
	call WriteString

	mov myMessage[2], "X"   ;[] - na urèitom mieste nahradí to èo je za zátvorkov
	call Crlf	; nový riadok
	call WriteString

	exit
main ENDP

END main