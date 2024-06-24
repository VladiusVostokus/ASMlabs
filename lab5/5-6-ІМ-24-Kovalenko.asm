.386
.model flat, stdcall
option casemap :none

include \masm32\include\masm32rt.inc
  

.data
    Oh_no db "OH NOOOO!", 0
 
    MsgBoxCaption5 db "Caluculation", 0

    ArrayOf_A_sses dd 12, -8, 20, -28, 4
    ArrayOf_C_sses dd -4, 10, 6, 24, 3
    ArrayOf_D_sses dd 6, 5, -8, -4, 2
    
    myFormulaBy6Variant db "(-2*ñ + d*82) / (a/4 - 1)",0  
     
    outputResultYEsEVEN DB "Formula=%s", 13, 10,
    "a=%d", 13,
    "c=%d", 13,
    "d=%d",13, 10,
    "result %d is even",13,10,
    "so if divide it on 2 result=%d" ,0
 
    outputResultYEsODD DB "Formula=%s", 13, 10,
    "a=%d", 13,
    "c=%d", 13,
    "d=%d",13, 10,
    "result %d is odd",13,10,
    "so if multipy it on 5 result=%d" ,0

    outputResultYEsZERO DB "Formula=%s", 13, 10,
    "a=%d", 13,
    "c=%d", 13,
    "d=%d",13, 10,
    "Anyway",13,10,
    "denominator is equal to zero, it can't be calculated" ,0

    divisorA dd 4
    multiplierD dd 82
    multiplierC dd -2

.data?
    buff db 128 DUP(?)
    buffA dd ?
    buffD dd ?
    buffC dd ?
    buff5 db 32 DUP(?)
    buffEAX dd ?

.code
start:

xor esi, esi

.repeat 
    
    xor eax, eax
    xor ebx, ebx
    xor ecx, ecx
    xor edx, edx
    
    mov eax, ArrayOf_A_sses[esi*4]
    mov ecx, ArrayOf_C_sses[esi*4]
    mov ebx, ArrayOf_D_sses[esi*4]

    inc esi

    mov buffA, eax
    mov buffC, ecx
    mov buffD, ebx
    
    cdq
    idiv divisorA  
         
    sub eax, 1
    
    .if eax==0
    invoke wsprintf, addr buff5, addr outputResultYEsZERO, addr myFormulaBy6Variant, buffA, \
    buffC, buffD
    invoke MessageBox, 0, addr buff5, addr Oh_no, 0
    invoke ExitProcess, 0
    .endif

    imul ecx, multiplierC
    imul ebx, multiplierD
    
    add ecx, ebx
    mov buffEAX, eax
    
    mov ebx, buffEAX
    mov eax, ecx
    
    cdq
    idiv ebx   
    mov ecx, eax

    cdq
    mov ebx,2
    idiv ebx 
    
    .if edx!=0
    mov eax, ecx
    imul eax, 5
    invoke wsprintf, addr buff5, addr outputResultYEsODD, addr myFormulaBy6Variant, buffA, \
    buffC, buffD, ecx, eax 
    invoke MessageBox, 0, addr buff5, addr MsgBoxCaption5, 0
    .continue
    .endif

    invoke wsprintf, addr buff5, addr outputResultYEsEVEN, addr myFormulaBy6Variant, buffA, \
    buffC, buffD, ecx, eax 
    invoke MessageBox, 0, addr buff5, addr MsgBoxCaption5, 0
    
    .until esi==5
    
    invoke ExitProcess , 0
    
end start