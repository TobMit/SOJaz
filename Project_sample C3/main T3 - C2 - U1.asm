TITLE MASM Template(main.asm)
INCLUDE Irvine32.inc
.data
dlzka equ 10
novaSprava DB dlzka dup(? ); neinicializovaná premenná
.code
main PROC
	call Clrscr

	mov edx, offset novaSprava
	mov ecx, dlzka

	call ReadString
	call WriteString

exit
main ENDP
END main

