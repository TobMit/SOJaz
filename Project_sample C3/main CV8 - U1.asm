TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data


	Poradie DW -7,26,-40,46,4,5,6,7,8,9,10,11,12

.code

VypisNajmensie PROC USES eax ebx edx esi ecx, paRetazec: dword
LOCAL NajmensieCislo: word
mov NajmensieCislo,0
xor eax, eax
xor esi, esi
mov ebx, paRetazec
Cyklus:
	cmp esi, 12
	jae Vypis
	mov ax, [ebx + 2 * esi]
	inc esi
	cmp ax,NajmensieCislo
	jge Cyklus
	mov NajmensieCislo, ax
	cmp esi, 12
	jb Cyklus


Vypis:
	xor eax,eax
	movsx eax, NajmensieCislo
	call WriteInt
ret
VypisNajmensie ENDP

main PROC
	INVOKE VypisNajmensie, OFFSET Poradie

	exit
main ENDP

END main