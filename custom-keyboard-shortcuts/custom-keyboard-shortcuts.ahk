#Requires AutoHotkey v2.0
SendMode "Input"  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir A_ScriptDir  ; Ensures a consistent starting directory.

^+d::
{
    ; Get the current date and time
    date := FormatTime(A_Now, "dddd, MMMM d, yyyy")
    time := FormatTime(A_Now, "h:mm tt")

    currentDateTime := date . " @ " . time . ":"

    ; Paste the date and time
    paste(currentDateTime)

}

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
        ; If more than 20 tries, notify of failure
        if (A_Index > 20)
            return TrayTip(A_ThisFunc ' failed to restore clipboard contents.')
    ; Otherwise, wait another 100ms
    else Sleep(100)
    until !DllCall('GetOpenClipboardWindow', 'Ptr')
    ; Finally, restore original clipboard contents
    A_Clipboard := clipbackup
}
