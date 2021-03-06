; https://codegolf.stackexchange.com/questions/35038/generate-the-group-table-for-z-n
BITS 64

section .text
	global	zn_asm

zn_asm:
	push		0xa		; used for division

	mov		ecx, edi
	dec		ecx		; set outer counter to n - 1
.l1:
	mov byte	[rsi], 0xa
	dec		rsi		; put newline in output

	mov		ebx, edi
	dec		ebx		; set inner counter to n - 1
.l2:
	mov		eax, ecx
	add		eax, ebx
	xor		edx, edx
	div		edi		; rdx now has (i + k) % n

	mov		eax, edx
.l3:					; loop converts integer to string (backwards)
	xor		edx, edx
	div qword	[rsp]		; divide our integer by 10
	add		edx, 0x30	; convert to ASCII

	mov byte	[rsi], dl
	dec		rsi

	test		eax, eax
	jne		zn_asm.l3

	dec		ebx		; inner loop
	test		ebx, ebx
	jge		zn_asm.l2

	dec		ecx		; outer loop
	test		ecx, ecx
	jge		zn_asm.l1

	pop		rax		; reset stack location
	mov		rax, rsi	; move pointer to string to return location
	inc		rax		; inc because rsi points to 1 byte before string

	ret
