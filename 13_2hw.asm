;두자리 10진수 숫자 세개를 입력받아 그 중 큰 것 두개를 더함
	
	main	segment
	assume	cs:main, ds:main

	mov	ax, cs
	mov	ds, ax

	; 10진수 2자리 숫자 세개 입력받아 저장

	mov	bx, offset array
	mov	cx , 3

input:
	mov	ah , 1  ; 에코있는 입력
	int 	21h
	sub	al , 48  ; 숫자로 바꿈
	mov	dl , 10  ; 10
	mul	dl ; ax <- al * 10
	mov	[bx] , ax

	mov	ah , 1  ; 에코있는 입력
	int 	21h
	sub 	al, 48
	mov	dl , 1
	mul	dl ; ax <- al * 1
	add	[bx] , ax
	
	add 	bx , 2
	loop 	input

	mov	ah, 02h
	mov	dl, 0dh  ; 줄 바꾸기
	int	21h

	mov	dl, 0ah  ; 줄 바꾸기
	int	21h

	;큰 숫자 두개 찾기 = 제일 작은 것 찾기

	mov	cx , 3

	mov	bx, offset array
	mov	ax , [bx]
	mov	smallest , ax
	mov	ad , bx  ; 제일 작은 것 주소 저장

small:	mov	ax , [bx]	
	cmp	ax , smallest
	jge	next 
	mov	smallest , ax
	mov	ad, bx

next:	add 	bx, 2	

	loop	small

	; 덧셈계산

	mov	bx , offset array
	mov	cx ,3

sum:	mov	ax , [bx]
	cmp	bx , ad
	je	n	; 제일 작은 수라면 더하지 않음
	add	ans, ax	

n:	add 	bx, 2
	loop 	sum

	; 10진수 출력
	mov	ax, ans
	mov	si, 10

loop1:
	mov	dx, 0
	div	si  ; ax의 값을 si로 나눈 후 몫은 ax에 저장, 나머지는 dx에 저장
	push 	dx ; 
	inc 	cx  ; cx<- cx+1
	cmp 	ax, 0  
	jne 	loop1 ; 몫 과 0이 not equal 이면 

print:	
	pop	dx
	add 	dl, '0'
	mov 	ah, 2
	int 	21h
	
	dec	cx
	cmp	cx,0
	jne	print

	mov	ah, 4ch
	int	21h

array	dw	?,?,?	
smallest	dw 	?
ans	dw	0
ad	dw 	?

main	ends   ; 세그먼트 종료
	end   
	