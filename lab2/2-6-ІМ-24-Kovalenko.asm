.386
.model flat, stdcall
option casemap :none

include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
include \masm32\include\windows.inc
include \masm32\include\masm32rt.inc

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib

.data
    MyBirthday DB "20092005",0

    A1_P DB 20
    A1_N DB -20
    A2_P DW 20
    A2_N DW -20
    B2_P DW 2009
    B2_N DW -2009

    A4_P DD 20
    A4_N DD -20
    B4_P DD 2009
    B4_N DD -2009
    C4_P DD 20092005
    C4_N DD -20092005

    A8_P DQ 20
    A8_N DQ -20
    B8_P DQ 2009
    B8_N DQ -2009
    C8_P DQ 20092005
    C8_N DQ -20092005

    D4_P DD 0.004
    D4_N DD -0.004

    E8_P DQ 0.395
    E8_N DQ -0.395

    F10_P DT 3948.124
    F10_N DT -3948.124

    ;Fractional numbers to output
    D_P DQ 0.004
    D_N DQ -0.004
    F_P DQ 3948.124
    F_N DQ -3948.124
    
    MsgBoxCaption DB "Number output", 0
    form DB "Birthday=%s", 13, 10,
    "A=%d", 13, 10,
    "-A=%d", 13, 10,
    "B=%d", 13, 10,
    "-B=%d", 13, 10,
    "C=%d", 13, 10,
    "-C=%d", 13, 10,
    "D=%s", 13, 10,
    "E=%s", 13, 10,
    "F=%s", 13, 10,
    "-D=%s", 13, 10,
    "-E=%s", 13, 10,
    "-F=%s", 0


.data?
    buff DB 128 DUP(?)
    buffD DB 32 DUP(?)
    buffE DB 32 DUP(?)
    buffF DB 32 DUP(?)
    buffD_N DB 32 DUP(?)
    buffE_N DB 32 DUP(?)
    buffF_N DB 32 DUP(?)

.code
start:
    invoke FloatToStr2, D_P, addr buffD
    invoke FloatToStr2, E8_P, addr buffE
    invoke FloatToStr2, F_P, addr buffF
    invoke FloatToStr2, D_N, addr buffD_N
    invoke FloatToStr2, E8_N, addr buffE_N
    invoke FloatToStr2, F_N, addr buffF_N

    invoke wsprintf , addr buff, addr form, 
        addr MyBirthday,
        A4_P,A4_N,
        B4_P,B4_N,
        C4_P,C4_N,
        addr buffD,
        addr buffE,
        addr buffF,
        addr buffD_N,
        addr buffE_N,
        addr buffF_N
    invoke MessageBox, NULL, addr buff, addr MsgBoxCaption, MB_OK
    invoke ExitProcess , 0
end start