﻿#Requires AutoHotkey v2.0
SendMode "Input"  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir A_ScriptDir  ; Ensures a consistent starting directory.

; KEYBOARD SHORTCUTS

; -----------------------Ctrl + Shift + key---------------------------

^+d:: ; Ctrl + Shift + D: Paste the current date and time
{
    ; Get the current date and time
    date := FormatTime(A_Now, "dddd, MMMM d, yyyy")
    time := FormatTime(A_Now, "h:mm tt")

    ; Format the date and time
    currentDateTime := date . " @ " . time . ":"

    ; Paste the date and time
    paste(currentDateTime)

}

^+t:: ; Ctrl + Shift + T: Paste the current time
{
    ; Get the current time
    time := FormatTime(A_Now, "h:mm tt")

    ; Format the time
    currentTime := time . ":"

    ; Paste the time
    paste(currentTime)

}

; ---------------------------Ctrl + key-------------------------------

^Numpad0:: ; Ctrl + Numpad 0 (NumLock on): Open Windows Terminal
{
    ; Open Windows Terminal
    Run ("C:\Users\jmaffiola\AppData\Local\Microsoft\WindowsApps\wt.exe")
}

^NumpadIns:: ; Ctrl + Numpad 0 (NumLock off): Open Windows Terminal
{
    ; Open Windows Terminal
    Run ("C:\Users\jmaffiola\AppData\Local\Microsoft\WindowsApps\wt.exe")
}

;---------------------------------------------------------------------

; FUNCTIONS

/*
    Function: paste
    Description: This function backs up the clipboard, pastes the data, and then restores the clipboard.
    Parameters:
        data - The data to be pasted.
*/
paste(data) {
    ; Backup clipboard
    clipbackup := ClipboardAll()
    ; Set new data to clipboard
    A_Clipboard := data
    ; Send the default paste command
    Send('^v')
    ; Check repeatedly to see if the clipboard is still open
    loop
        if (A_Index > 20) ; If more than 20 tries, notify of failure
            return TrayTip(A_ThisFunc ' failed to restore clipboard contents.')
        else Sleep(100) ; Otherwise, wait another 100ms
    until !DllCall('GetOpenClipboardWindow', 'Ptr')
    ; Finally, restore original clipboard contents
    A_Clipboard := clipbackup
}
