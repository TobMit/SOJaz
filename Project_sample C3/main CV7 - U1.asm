TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

	IOBuffer dword 6 dup (0),0

	Sprava DB 'Nacitajte cele cislo bez znamienka v rozsahu <0 65535>', 0Dh, 0Ah, 0  ;0Dh a 0Ah hodi na nov˝ riadok
	SpravaChyba DB 'Chybny vstup', 0Dh, 0Ah, 0

.code

StrToInt PROC USES eax ebx edx, paRetazec: dword
LOCAL jeZaporne: byte
mov edx, paRetazec
xor bx, bx
xor esi, esi
L1:	
		mov al, [edx + esi]		
		inc esi
		cmp al, 0							
		je L3
		cmp al, '-'
		je Minusko
		cmp al, '+'
		je L1
		cmp al, '0'							
		jb ZlyVstup		
		cmp al, '9'							
		ja ZlyVstup		
		and al, 0fh		;premenÌ hodnotu na dec
		cmp bx, 0
		je L2
		imul bx, 10
		cmp dx, 0 ;toto je druh· kontrola ktor· eöte nieje dokonËen·, toto je explicitne eöte nefunguje
		jnz ZlyVstup
		add bx,ax 
		jc ZlyVstup
		jmp L1

	Minusko:
		mov jeZaporne, 1
		jmp L1

	L2:
		add bx, ax
		jmp L1
	
	ZlyVstup:
		mov edx, OFFSET SpravaChyba 
		call WriteString
		exit
	L4:
		imul bx, (-1)
		mov jeZaporne, 0
		jmp L3
	L3:
		cmp jeZaporne, 1
		je L4
		movsx eax, bx		;aby fungovalo znamienko treba to hodiù cez movsx a do eax
		call WriteInt


ret
StrToInt ENDP

main PROC
	mov edx, OFFSET IOBuffer
	mov ecx, sizeof IOBuffer
	call readString
	INVOKE StrToInt, OFFSET IOBuffer
	exit
main ENDP

END main