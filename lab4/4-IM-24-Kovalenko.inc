
messageBoxMacro macro windowInfo, windowTitle
    invoke MessageBox, 0, addr windowInfo, addr windowTitle, 0
    ;;I like playing Rocket League
    ;I also like playing Minecraft
endm


xor2Value macro val1, val2
    xor val1, val2
    ;;I my opinion this is the best games ever
    ;However, I have no Minecraft licenñe
endm


checkOnEqualityMacro macro val1,val2
    local IsEqualOrEnd

    IsEqualOrEnd:
            .if val1!=val2
                messageBoxMacro badSecretText, badSecretTitle
		    invoke ExitProcess, 0
		    .endif

                .if val1==0      
                showAllWindows
                .endif

                .if val2==0      
                showAllWindows
                .endif

    ;;One day I will buy it
    ;And will be very happy!
endm


showAllWindows macro
    messageBoxMacro mySurname, hidenWindowTitle
    messageBoxMacro myName, hidenWindowTitle
    messageBoxMacro myPatronymic, hidenWindowTitle
    messageBoxMacro myBirthday, hidenWindowTitle
    invoke ExitProcess, 0
    ;;Actually, I don't need comments here
    ;Because this is optional macro, but just in case
endm
