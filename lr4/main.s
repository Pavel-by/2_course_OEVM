	.file	"main.c"
	.intel_syntax noprefix
	.text
	.def	__main;	.scl	2;	.type	32;	.endef
	.section .rdata,"dr"
.LC0:
	.ascii "%d\0"
	.text
	.globl	main
	.def	main;	.scl	2;	.type	32;	.endef
	.seh_proc	main
main:
	push	rbp
	.seh_pushreg	rbp
	push	rdi
	.seh_pushreg	rdi
	push	rsi
	.seh_pushreg	rsi
	sub	rsp, 464
	.seh_stackalloc	464
	lea	rbp, 128[rsp]
	.seh_setframe	rbp, 128
	.seh_endprologue
	call	__main
	lea	rax, 240[rbp]
	mov	rcx, rax
	call	gets
	lea	rdx, 240[rbp]
	lea	r8, -96[rbp]
/APP
 # 21 "main.c" 1
	.intel_syntax noprefix
	cld
mov rsi, rdx
	mov rdi, r8
	TRANSFORM:mov cx,0
	mov al,[rsi]
	cmp al,'0'
jl NOT_NUMBER
cmp al,'9'
jg CHECK_LOW
sub al,'0'
jmp TO_BIN
CHECK_LOW:
cmp al,'a'
jl NOT_NUMBER
cmp al,'h'
jg NOT_NUMBER
sub al,'a'
add al,10
jmp TO_BIN
TO_BIN:
mov ah,al
and ah,1
add ah,'0'
push ax
inc cx
shr al
cmp al,0
jg TO_BIN
WRITE:
pop ax
mov [rdi],al
inc rdi
dec cx
cmp cx,0
jg WRITE
inc rsi
jmp TRANSFORM
NOT_NUMBER:
MOVSB
cmp al,0
jg TRANSFORM

 # 0 "" 2
/NO_APP
	lea	rax, -96[rbp]
	mov	rcx, rax
	call	puts
	movzx	eax, BYTE PTR -96[rbp]
	movsx	eax, al
	mov	edx, eax
	lea	rcx, .LC0[rip]
	call	printf
	mov	eax, 0
	add	rsp, 464
	pop	rsi
	pop	rdi
	pop	rbp
	ret
	.seh_endproc
	.ident	"GCC: (x86_64-posix-seh-rev0, Built by MinGW-W64 project) 8.1.0"
	.def	gets;	.scl	2;	.type	32;	.endef
	.def	puts;	.scl	2;	.type	32;	.endef
	.def	printf;	.scl	2;	.type	32;	.endef
