main	segment
	assume	cs:main, ds:main

	mov 	ax, cs
	mov	ds, ax

	; 문자열 출력
	mov	dx , offset msg
	mov	ah , 9
	int 	21h

	; 소문자 찾기
	mov	cx , 100
	mov	bx , offset msg
	
a1:	mov	al , [bx]
	cmp	al , 'a'
	jb	next	; 작으면
	
a2:	cmp	al , 'z'
	ja	next	; 크면
	add	al, 'A'-'a' ;소문자만 남아있음 -> 대문자로
	mov	[bx], al

next:	add	bx , 1
	loop	a1

	; 줄 바꾸기
	mov	ah, 02h
	mov	dl, 0dh
	int	21h

	mov	dl, 0ah
	int	21h
	
	; 바꾼 문자열 출력
	mov	dx , offset msg
	mov	ah , 9
	int 	21h

	mov 	ah, 4ch
	int 	21h	
	
msg   db  'HaPPiNESS cOMeS aFTER FRUSTRATIOn LIkE THE sUN COMeS OuT AfTeR RAIn$'   ; 100글자 이내의 문자열 저장

main	ends
	end