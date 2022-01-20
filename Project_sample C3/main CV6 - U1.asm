TITLE MASM Template						(main.asm)

INCLUDE Irvine32.inc
.data

	IOBuffer dword 6 dup (0)
	Cislo DB 6 dup(?)
	znamienko byte 0
	Sprava DB 'Nacitajte cele cislo bez znamienka v rozsahu <0 65535>', 0Dh, 0Ah, 0  ;0Dh a 0Ah hodi na nov˝ riadok
	SpravaChyba DB 'Chybny vstup', 0Dh, 0Ah, 0

.code
main PROC


	mov edx, OFFSET IOBuffer
	mov ecx, sizeof IOBuffer
	call readString
	xor edx, edx
	xor bx, bx

	lea edx, IOBuffer
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
		add bx,ax 
		jmp L1

	Minusko:
		mov znamienko, 1
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
		mov znamienko, 0
		jmp L3
	L3:
		;cmp znamienko, 1
		;je L4
		;movsx eax, bx		;aby fungovalo znamienko treba to hodiù cez movsx a do eax

		mov dl,10
		mov edi, 6
		jmp Spracuj

	Spracuj:
		dec edi
		mov ax, bx
		div dl
		or al, 30h
		movzx bx, al
		movzx cx, ah
		mov Cislo[edi], ah
		cmp edi, 0
		jne Spracuj
		xor edi, edi
		cmp edi, 0
		je Vypis

	Vypis:
		movzx ebx, Cislo
		mov al, [ebx + esi]
		cmp al, 0
		je Koniec
		call writeChar
		jmp Vypis
	Koniec:
		
		exit
		
	exit
main ENDP

END main