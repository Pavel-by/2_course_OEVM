; �祡��� �ணࠬ��  ������୮� ࠡ��� �2 �� ���樯���� "���⥪��� ��������"
;
;
EOL  EQU  '$'
ind  EQU   2
n1   EQU  500
n2   EQU  -50

; �⥪  �ணࠬ��

AStack    SEGMENT  STACK
          DW 12 DUP(?)
AStack    ENDS

; ����� �ணࠬ��

DATA      SEGMENT

;  ��४⨢� ���ᠭ�� ������

mem1      DW    0
mem2      DW    0
mem3      DW    0
vec1      DB    1,2,3,4,8,7,6,5
vec2      DB    -10,-20,10,20,-30,-40,30,40
matr      DB    1,2,3,4,-4,-3,-2,-1,5,6,7,8,-8,-7,-6,-5

DATA      ENDS

; ��� �ணࠬ��

CODE      SEGMENT
          ASSUME CS:CODE, DS:DATA, SS:AStack

; �������� ��楤��
Main      PROC  FAR
          push  DS
          sub   AX,AX
          push  AX
          mov   AX,DATA
          mov   DS,AX
	
	mov ax, mem2
	
          ret  
Main      ENDP
CODE      ENDS
          END Main
