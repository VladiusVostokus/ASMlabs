
.386
.model flat, stdcall
option casemap :none

include \masm32\include\masm32rt.inc
includelib \masm32\lib\msvcrt.lib
include 4-IM-24-Kovalenko.inc


.data?
    secretWordInput     db 10 dup (?)

.data
    hidenWindowTitle db "Student info", 0
    myInfo        db "Kovalenko Vladislav Yuriiovych", 13, 10, "20.09.2005", 13, 10, "5089", 0
    mySurname     db "Kovalenko", 0
    myName        db "Vladislav", 0
    myPatronymic  db "Yuriiovych", 0
    myBirthday	db "20.09.2005", 0
    badSecretTitle    db "Bad secret word", 0
    badSecretText    db "You ented bad secret word", 0
    secretWord       db "PPPPP", 0
    xorKey          db "abcde", 0 

dialogHandler	PROTO :DWORD, :DWORD, :DWORD, :DWORD

.code	
main:    
	Dialog "Some text", "Arial", 15, \
        WS_OVERLAPPED or WS_SYSMENU or DS_CENTER, \   							
        4, 10, 10, 200, 150, 1024

	DlgStatic "Write a secret word", SS_CENTER, 50,  12, 100,  10, 100	
	DlgEdit   WS_BORDER, 10,  25, 180, 15, 5089		
	DlgButton "Go", WS_TABSTOP, 10,  55, 50,  15, IDOK 				
	DlgButton "Quit", WS_TABSTOP, 140, 55, 50,  15, IDCANCEL 	

	CallModalDialog 0, 0, dialogHandler, NULL


     checkOnEquality proc
            mov esi, offset secretWord
            mov edi, offset secretWordInput
            mov ebp, offset xorKey

            IsWordsEqual:
                
                mov al, byte ptr [edi]
                mov bl, byte ptr [esi]
                mov ah, byte ptr [ebp]
                
                xor2Value al, ah

                checkOnEqualityMacro al, bl
                
                inc esi
                inc edi
                inc ebp
                jmp IsWordsEqual

		return 0
	checkOnEquality endp

	dialogHandler proc hWnd:DWORD, uMsg:DWORD, wParam:DWORD, lParam:DWORD
            .if uMsg==WM_INITDIALOG
            jmp createDialogWindow

            .elseif uMsg==WM_CLOSE
		   invoke ExitProcess, 0

            .elseif uMsg==WM_COMMAND
               jmp handleOKorCANSEL

            .elseif uMsg==10
            mov eax,10
            .endif

		createDialogWindow:
			invoke GetWindowLong, hWnd, GWL_USERDATA
			return 0

		handleOKorCANSEL:
			.if wParam==IDOK
			invoke GetDlgItemText, hWnd, 5089, offset secretWordInput, 10
			call checkOnEquality
			return 0

			.elseif wParam==IDCANCEL
			invoke ExitProcess, 0
                  .endif
			return 0
			
	dialogHandler endp
end main