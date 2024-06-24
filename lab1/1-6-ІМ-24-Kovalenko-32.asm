
.386
.model flat, stdcall
option casemap :none

include \masm32\include\kernel32.inc
include \masm32\include\user32.inc
include \masm32\include\windows.inc

includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\user32.lib

.data
    myInfo db  "Kovalenko Vladislav Yuriiovych", 13, 10, "20.09.2005", 13, 10, "5089", 0
    headline db  "Student Info", 0

.code

start:
    invoke MessageBox, NULL, addr myInfo, addr headline, MB_OK
    invoke ExitProcess , 0
end start