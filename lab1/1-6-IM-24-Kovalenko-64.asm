OPTION DOTNAME	
option casemap:none

include \masm64\include\temphls.inc
include \masm64\include\win64.inc
include \masm64\include\kernel32.inc
include \masm64\include\user32.inc

includelib \masm64\lib\kernel32.lib
includelib \masm64\lib\user32.lib

OPTION PROLOGUE:rbpFramePrologue
OPTION EPILOGUE:none

.data
    myInfo db  "Kovalenko Vladislav Yuriiovych", 13, 10, "20.09.2005", 13, 10, "5089", 0
    headline db  "Student Info", 0
.code

WinMain proc 
	sub rsp,28h
    invoke MessageBox, NULL, &myInfo, &headline, MB_OK
    invoke ExitProcess,NULL
WinMain endp
end
