BITS 16

start:
	mov	ax, 07C0h		; Set up 4K stack space after this bootloader
	add	ax, 288			; (4096 + 512) / 16 bytes per paragraph
	mov	ss, ax
	mov	sp, 4096

	mov	ax, 07C0h		; Set data segment to where we're loaded
	mov	ds, ax

	int	11h

        str0        db      'Jumping to finished label.', 0h
        str1        db      'Inside subroutine number: ', 0h

	mov	si, str0		; Put string position into SI
	call	println

	mov	si, str1
	call	println

	jmp	$

	call	end

print:
	mov	ah, 0Eh
	.print:
		lodsb
		cmp	al, 00h
		je	.done
		int	10h
		jmp	.print
		.done:
			ret

ln:
	mov	ah, 0Eh
	mov	al, 0Ah
	int	10h
	mov	al, 0Dh
	int	10h
	ret

println:
	call	print
	call	ln
	ret

end:
        times	510-($-$$) db 00h	; Pad remainder of boot sector with 0s
        dw	0xAA55			; The standard PC boot signature
	ret

; Next Step: 
