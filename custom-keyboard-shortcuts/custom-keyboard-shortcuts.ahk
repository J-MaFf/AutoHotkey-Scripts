#Requires AutoHotkey v2.0
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

;------------------------Ctrl + Alt + key-----------------------------

^!m:: ; Ctrl + Alt + M: Convert Markdown to HTML and copy to clipboard
{
    ; Copy selected text to clipboard
    Send('^c')
    Sleep(100) ; Wait for clipboard to update

    ; Get the Markdown text from the clipboard
    markdown := A_Clipboard

    ; Convert Markdown to HTML (using a simple conversion function)
    html := markdownToHTML(markdown)

    ; Store the HTML in the clipboard
    A_Clipboard := html

    ; Notify the user
    TrayTip("Markdown to HTML", "HTML copied to clipboard", 1)
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

markdownToHtml(markdown) {
    ; Prepare the command to send the Markdown text to the GitHub API
    command :=
        "curl -L -X POST -H `"Accept: application/vnd.github+json`" -H `"Authorization: Bearer <op://Employee/vysu2k4k3lx6aujev5m6ea36ly/credential>`" -H `"X-GitHub-Api-Version: 2022-11-28`" https://api.github.com/markdown -d `"{`"text`":`"" markdown` ""` "}`"

    ; Create a temporary file to store the markdown content
    tempFile := A_Temp "\markdown_input.md"
    FileAppend(markdown, tempFile)

    ; Update the command to read from the temporary file
    command := command . " < " . tempFile

    ; Run the command and get the result
    runWaitOne(command, html)

    ; Delete the temporary file
    FileDelete(tempFile)

    return html
}

runWaitOne(command, &output) {
    ; Run the command and capture the output
    shell := ComObject("WScript.Shell")
    exec := shell.Exec(command)
    output := exec.StdOut.ReadAll()
}
