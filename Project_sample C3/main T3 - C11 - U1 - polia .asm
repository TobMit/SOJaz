TITLE MASM Template(main.asm)
INCLUDE Irvine32.inc
.data
;		x os		0	1	2	3	4	5  yos
		Matica	DW 00, 01, 02, 03, 04, 05; 0
				DW 10, 11, 12, 13, 14, 15; 1
				DW 20, 21, 22, 23, 44, 55; 2
	dlzkaRaidku equ sizeof Matica		; vr·ti dlzku jednÈho riadku v mojom prÌpade je to 12 pretoûe pouûÌwam word

.code



main PROC
	xor eax, eax
	IndexRiadku equ 0
	IndexStlpca equ 0

	mov ebx, dlzkaRaidku* IndexRiadku		; dlûka sa nasobÌ ËÌslom riadku pre to aby sme dostali adresu v pameti
											; v pameti s˙ uloûenÈ inform·cie v matici za sebou, tak preto sa nasobÌ öÌrk matice s riadkom
	mov esi, indexStlpca
	mov ax, Matica[ebx + esi * type Matica]		;je povinnosù vûdy vynasobyù index stlpca s type Matica
	call WriteInt

exit
main ENDP
END main

