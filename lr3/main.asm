
AStack    SEGMENT  STACK
          DW 12 DUP(?)
AStack    ENDS

; Данные программы

DATA      SEGMENT

i1	DW 0
i2	DW 0
res	DW ?

a 	DW 1
b	DW 2
i 	DW 3
k	DW 1

DATA      ENDS

; Код программы

CODE      SEGMENT
          ASSUME CS:CODE, DS:DATA, SS:AStack

; Головная процедура
Main      PROC  FAR

	; Push PSP address to exit
	push ds
	mov ax,0
	push ax
	; Set up DS
	mov ax, DATA
	mov ds, ax
	
	mov ax,a
	cmp ax,b
	mov ax, i ; set up ax = i
	jl a_L_b	
	
a_G_b:	
	shl ax, 1
	shl ax, 1
	mov cx,ax ; cx = i * 4
	add ax, 3
	neg ax
	mov i1,ax
	
	neg cx
	add cx,20
	mov i2,cx

	jmp f_res
	
a_L_b:	
	shl ax,1
	mov cx,ax
	add ax,cx
	add ax,cx
	mov cx,ax ; cx = 6*i
	sub ax,10
	mov i1,ax
	
	add cx,6
	neg cx
	mov i2,cx
	
f_res:	
	cmp cx,0 ; compute |i2|
	jl i2_G_0
	neg cx
i2_G_0:	
	mov ax,k ; comparing k > 0
	cmp ax,0
	jge k_GE_0
	
k_L_0:
	mov ax,i1
	cmp ax,0 ; модуль i1
	jg i1_G_0
	neg ax
i1_G_0:	sub ax,cx
	mov res,ax
	
	jmp exit

k_GE_0:
	cmp cx,7
	jg i2_G_7
	mov res,7 ; 7 >= i
	jmp exit
i2_G_7:	mov res,cx

exit:	
	mov ax,i1
	mov ax,i2
	mov ax,res
	ret
Main      ENDP
CODE      ENDS
          END Main
