.386
.model flat, stdcall
option casemap :none

include \masm32\include\masm32rt.inc
  

.data
    Oh_no db "OH NOOOO!", 0
 
    MsgBoxCaption5 db "Caluculation", 0

    ArrayOf_A_sses dq 14.2 ,12.4 ,10.1 ,3.6 ,11.3
    ArrayOf_B_sses dq 2.7 ,3.1 ,8.9 ,-7.3, 3.5
    ArrayOf_C_sses dq -3.4, -3.8, 4.3, 40.7, 31.6
    ArrayOf_D_sses dq 4.1, 6.1, 5.4, 5.1, 9.8
    
    myFormulaBy6Variant db "(-2*c – sin(a/d) + 53) / ((a/4) –b)",0 

    testForm db "result=%s",0
 
    outputResultYEs DB "Formula=%s", 13,
    "a=%s", 13, 10,
    "b=%s", 13, 10,
    "c=%s", 13, 10,
    "d=%s", 13, 10,
    "result=%s", 0

 
    outputResultYEsZERO DB "Formula=%s", 13,
    "a=%s", 13, 10,
    "b=%s", 13, 10,
    "c=%s", 13, 10,
    "d=%s", 13, 10,
    "Anyway",13,
    "denominator is equal to zero, it can't be calculated" ,0

    divisorA dq 4.0
    multiplyC dq -2.0
    additiveSin dq 53.0

.data?
    buffRes db 64 DUP(?)
    buffResA db 64 DUP(?)
    buffResB db 64 DUP(?)
    buffResC db 64 DUP(?)
    buffResD db 64 DUP(?)

    buff db 512 DUP(?)
    buffNO db 512 DUP(?)
    denominator dt ?
    result dq ?
    sinValue dt ?
    
.code
start:

xor esi, esi

.repeat 

    startOfLoop:
    
    invoke FloatToStr, ArrayOf_A_sses[esi*8], addr buffResA
    invoke FloatToStr, ArrayOf_B_sses[esi*8], addr buffResB
    invoke FloatToStr, ArrayOf_C_sses[esi*8], addr buffResC
    invoke FloatToStr, ArrayOf_D_sses[esi*8], addr buffResD

    finit
    fld ArrayOf_A_sses[esi*8]
    fdiv divisorA
    fsub ArrayOf_B_sses[esi*8]

    fstp denominator
    fldz
    fld denominator
    fcompp
    fstsw ax
    sahf
    je veryBigProblem
    
    fld ArrayOf_A_sses[esi*8]
    fld ArrayOf_D_sses[esi*8]
    fdiv
    
    fsin
    fstp sinValue
    
    fld multiplyC
    fld ArrayOf_C_sses[esi*8]
    inc esi
    fmul

    fld sinValue
    fsub 
    fadd additiveSin

    fld denominator
    fdiv 
    fstp result    

    invoke FloatToStr, result, addr buffRes
    invoke wsprintf, addr buff, addr outputResultYEs, addr myFormulaBy6Variant, addr buffResA, addr buffResB, \
    addr buffResC, addr buffResD, addr buffRes
    invoke MessageBox, 0, addr buff, addr MsgBoxCaption5, 0
   
    .until esi==5

    invoke ExitProcess, 0

    veryBigProblem:
        inc esi
        invoke wsprintf, addr buffNO, addr outputResultYEsZERO, addr myFormulaBy6Variant, addr buffResA, addr buffResB, \
        addr buffResC, addr buffResD, addr buffRes
        invoke MessageBox, 0, addr buffNO, addr Oh_no, 0
        jmp startOfLoop
    
end start