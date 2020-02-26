
AStack    SEGMENT  STACK
          DW 1024 DUP(?)
AStack    ENDS

; Данные программы

DATA      SEGMENT

KEEP_V	DD	0
TACTS_REMAIN DW 	36 ; waiting for 2 seconds
MESSAGE	DB 'wait two seconds, please',10,13,'$'
THANK	DB 'ok',10,13,'$'

DATA      ENDS

; Код программы

CODE      SEGMENT
          ASSUME CS:CODE, DS:DATA, SS:AStack


Main 	PROC FAR

	mov al, 1
	mov dl, 1
	mov ah, 33h
	int 21h

          push  DS
          sub   AX,AX
          push  AX
          mov   AX,DATA
          mov   DS,AX

	mov ah,35h ; get vector
	mov al,08h
	int 21h
	mov word ptr KEEP_V, bx
	mov word ptr KEEP_V+2, es
	
	push ds ; set custom vector
	mov dx, offset IWorker
	mov ax, seg IWorker
	mov ds, ax
	mov ah, 25h
	mov al, 08h
	int 21h
	pop ds
	
Delay:	; wait until TACTS_REMAIN more than 0
	mov ax,[TACTS_REMAIN]
	cmp ax, 0
	jg Delay
	
	
	mov ah, 09h
	mov dx, offset THANK
	int 21h
	
	cli ; restore vector
	push ds
	mov dx, word ptr KEEP_V
	mov ax, word ptr KEEP_V+2
	mov ds, ax
	mov ah, 25h
	mov al, 08h
	int 21h
	pop ds
	sti
	
	ret

Main	ENDP



IWorker	PROC FAR

	pushf ; call "super method"
	call dword ptr [KEEP_V]
	
	push ax
	push dx
	push cx
	
	mov ax, [TACTS_REMAIN]
	dec ax
	mov TACTS_REMAIN, ax
	
	mov ah, 2ch
	int 21h
	
	mov ax, 0
	mov al, cl
	push ax
	call print
	
	mov ah, 02h
	mov dl, ':'
	int 21h
	
	mov ax, 0
	mov al, dh
	push ax
	call print
	
	mov ah, 02h
	mov dl, 10
	int 21h
	
	mov ah, 02h
	mov dl, 13
	int 21h
	
	pop cx
	pop dx
	pop ax
	mov al, 20h
	out 20h, al
	iret
	
IWorker	ENDP


print 	PROC NEAR 

	push ax
	push dx
	push bp
	
	mov bp, sp
	mov ax, [bp]+8
	mov dl, 10d
	div dl
	
	mov dx, ax
	add dx,3030h
	mov ah, 02h
	int 21h
	
	mov dl,dh
	int 21h
	
	pop bp
	pop dx
	pop ax
	ret 2

print 	ENDP

CODE      ENDS
          END Main
