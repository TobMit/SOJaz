TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

	Velkost equ 12
	Poradie DW Velkost dup(?)

.code

NacitajArray PROC USES esi eax ecx
mov ecx, Velkost
xor eax,eax
Cyklus:
	call ReadInt
	mov poradie[ecx], ax
	loop Cyklus
	
ret
NacitajArray ENDP




VypisNajmensie PROC USES eax ebx edx esi ecx, paRetazec: dword
LOCAL NajmensieCislo: word
xor eax, eax
xor esi, esi
mov ebx, paRetazec
;mov ax, [ebx]  ;ochrana pred tým ak sa v pradí nevyskytla 0 tak aby ani vo vípyse nebola nula (pri deklarovaní local premennej sa vždy nuluje)
;mov NajmensieCislo, ax
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
	INVOKE NacitajArray
	INVOKE VypisNajmensie, OFFSET Poradie

	exit
main ENDP

END main