TITLE MASM Template(main.asm)
INCLUDE Irvine32.inc
.data

hlaskaOdvesna1 DB "Zadajte prvu odvesnu: ", 0
hlaskaOdvesna2 DB "Zadajte prvu odvesnu: ", 0
hlaskaPrepona DB "Prepona je: ", 0

Uvod DB "Program vypocita preponu trojuholnika!", 0Dh, 0Ah, 0

odvesna1 real10 ?
odvesna2 real10 ?


.code



main PROC
	finit; inicializacia FPU procesora
	mov edx, offset Uvod
	call WriteString

	mov edx, offset hlaskaOdvesna1
	call WriteString
	call ReadFloat
	fstp odvesna1; ulozi obsah st(0) od premennej

	mov edx, offset hlaskaOdvesna1
	call WriteString
	call ReadFloat
	fstp odvesna2; ulozi obsah st(0) od premennej

	fld odvesna1; ulozží do st(0) hodnotu  premennej
	fmul st(0), st(0); vynásobý st(0) a st(0) v mojom prípade je to a* a = a ^ 2

	fld odvesna2
	fmul st(0), st(0)

	fadd; sèíta st(0) a st(1)
	fsqrt; odmocnina st(0)
	call WriteFloat;vypíše hodnotu z st(0)

exit
main ENDP
END main

