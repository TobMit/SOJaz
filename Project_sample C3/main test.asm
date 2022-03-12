TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data
R DB "koniec",0

.code
main PROC
	call Clrscr

	mov	 edx,OFFSET R
	call WriteString

	exit
main ENDP

END main