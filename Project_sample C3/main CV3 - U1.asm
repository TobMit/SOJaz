TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data
myMessage BYTE "Assembly language program example",0

.code
main PROC
	call Clrscr

	mov	 edx,OFFSET myMessage
	call WriteString

	mov myMessage[2], "X"   ;[] - na ur�itom mieste nahrad� to �o je za z�tvorkov
	call Crlf	; nov� riadok
	call WriteString

	exit
main ENDP

END main