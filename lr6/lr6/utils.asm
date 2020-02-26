.586
.MODEL FLAT, C
.CODE

FILL_MAS PROC ; xMin: dword, xMax: dword, numbers: dword, nCount: dword, mas: dword
		push ebp
		mov ecx, 0
cycle:	mov ebp, [esp+16]
		mov eax, [ebp+ecx*4]
		sub eax, [esp+8]

		mov ebp, [esp+24]
		mov esi, [ebp+eax*4]
		inc esi
		;add ebp,eax
		mov [ebp+eax*4], esi

		inc ecx
		cmp ecx, [esp+20]
		jl cycle
		pop ebp
		ret 

FILL_MAS ENDP

COMPUTE_LIMITS PROC ; xMin:dw, xMax:dw, mas:dw, limitArr:dw, outArr:dw, limitMaxIndex:dw
		push ebp
		mov ecx, [esp+2*4] ; current X
		mov esi, 0 ; limit counter

check_exit:	
		cmp ecx, [esp+3*4]
		jg exit

check_limit:
		cmp esi, [esp+7*4]
		jge limit_is_normal ; check is it last limit
		
		mov ebp, [esp+5*4] 
		cmp ecx, [ebp+esi*4] ; cmp 
		jl limit_is_normal
		inc esi
		jmp check_limit

limit_is_normal:
		mov ebp, [esp+4*4]
		sub ecx, [esp+2*4] ; choose cur mas index
		mov eax, [ebp+ecx*4] ; mas's item
		add ecx, [esp+2*4]
		mov ebp, [esp+6*4] ; out array
		add eax, [ebp+esi*4]
		mov [ebp+esi*4], eax

		inc ecx
		jmp check_exit

exit:	pop ebp
		ret

COMPUTE_LIMITS ENDP

; Подсчитать произведение в range-х
COMPUTE_PR PROC ; xMin:dw, xMax:dw, mas:dw, limitArr:dw, outArr:dw, limitMaxIndex:dw
		push ebp
		mov ecx, [esp+2*4] ; current X
		mov esi, 0 ; limit counter

check_exit:	
		cmp ecx, [esp+3*4]
		jg exit

check_limit:
		cmp esi, [esp+7*4]
		jge limit_is_normal ; check is it last limit
		
		mov ebp, [esp+5*4] 
		cmp ecx, [ebp+esi*4] ; cmp 
		jl limit_is_normal
		inc esi
		jmp check_limit

limit_is_normal:
		mov ebp, [esp+4*4]
		sub ecx, [esp+2*4] ; choose cur mas index
		mov eax, [ebp+ecx*4] ; mas's item
		add ecx, [esp+2*4]
		cmp eax, 0
		je no_such_numbers ; jump over multipling if we have not any numbers for current X (ecx)

		dec eax
		sub ecx, [esp+2*4] ; choose cur mas index
		mov [ebp+ecx*4], eax ; set decremented value (it means, that we have tooken one X (ecx) number and have multiplied it to total product)
		add ecx, [esp+2*4]
		mov ebp, [esp+6*4] ; out array
		push edx
		mov eax, [ebp+esi*4]
		mul ecx ; multiply on current X value 
		pop edx
		mov [ebp+esi*4], eax
		jmp limit_is_normal ; repeat cycle until we have X values
no_such_numbers:
		inc ecx
		jmp check_exit

exit:	pop ebp
		ret

COMPUTE_PR ENDP
END