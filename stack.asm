 ; 한자리 숫자
 10개를 차례로 입력받아 입력 반대 순서대로 화면에 출력하는 프로그램
; 순서 바꾸는 법은 스택을 이용

code	segment
	assume	cs:code
	
	mov cx , 10 ; 10번 입력 받음

loop1:	
	mov	ah, 1  	; echo 있는 입력 al에 저장됨
	int	21h
	
	push	ax	; 입력받은 값 stack에 push  
			; stack은 16bit 단위로 저장됨

	loop	loop1  ; 10번 입력받음
	
line:	
	mov	dl, 0dh	; 커서를 다음 줄로 바꿈
	mov	ah, 2 
	int 	21h
	mov	dl, 0ah	; 커서를 맨 첫 칸으로 옮김
	mov	ah, 2 
	int 	21h

	mov	cx, 10 ; 입력받은 10개 출력
print:	

	pop	bx	; stack 에서 pop한 것 bx에 저장
	mov 	dl, bl	; 하위 비트값이 입력 한 값. dl에 저장

	mov	ah, 2 	; dl에 있는 값 출력
	int 	21h
	
	loop	print	; 10번 출력
exit:
	mov	ah, 4ch
	int 	21h
	
code	ends
	end
	