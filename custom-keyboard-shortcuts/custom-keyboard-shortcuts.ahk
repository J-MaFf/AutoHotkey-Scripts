#Requires AutoHotkey v2.0
SendMode "Input"  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir A_ScriptDir  ; Ensures a consistent starting directory.

; KEYBOARD SHORTCUTS

; -----------------------Caps lock hyper key--------------------------

*CapsLock::
{
    ; 1. Press down Ctrl, Alt, and Shift instantly
    Send "{Ctrl Down}{Alt Down}{Shift Down}"

    ; 2. Wait right here until you physically release the Caps Lock key
    KeyWait "CapsLock"

    ; 3. Release Ctrl, Alt, and Shift
    Send "{Ctrl Up}{Alt Up}{Shift Up}"

    ; 4. Check if you pressed another key while holding Caps Lock.
    ; If you didn't, toggle the actual Caps Lock state.
    if (A_PriorKey = "CapsLock") {
        SetCapsLockState !GetKeyState("CapsLock", "T")
    }
}

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

^!m:: ; Ctrl + Alt + M: Convert Markdown to HTML
{
    ; Get the Markdown text from the clipboard
    markdown := A_Clipboard

    ; Convert Markdown to HTML (using a simple conversion function)
    html := markdownToHTML(markdown)

    ; Store the HTML in the clipboard
    A_Clipboard := html

    ; Notify the user that the HTML is ready
    TrayTip("Markdown to HTML", "Ready to paste HTML", 1)
}
^+!h:: ; Ctrl + Shift + Alt + H (Hyper key + H): Convert selected text to uppercase and paste
{
    ; Get active window to ensure we can come back to it
    activeWin := WinGetID("A")

    ; Clear clipboard
    A_Clipboard := ""
    ; Release all modifier keys to avoid interference with copy
    Send("{Ctrl Up}{Shift Up}{Alt Up}")
    Sleep(50)
    ; Copy selected text
    Send("^c")

    ; Wait for clipboard to contain data (timeout after 2 seconds)
    if !ClipWait(2) {
        ; Notify the user that the clipboard is empty
        TrayTip("Error", "No text selected or clipboard operation failed", 1)
        return
    }

    ; Get the text and convert to uppercase
    lowercase := A_Clipboard
    uppercase := StrUpper(lowercase)

    ; Store original clipboard content
    clipBackup := ClipboardAll()

    ; Set clipboard to uppercase text
    A_Clipboard := uppercase

    ; Ensure we're still focused on the original window
    WinActivate("ahk_id " activeWin)

    ; Add delay to ensure window is ready
    Sleep(100)

    ; Try to paste with retry logic for compatibility
    pasteSuccess := false
    loop 3 {  ; Try up to 3 times
        Send("^v")
        Sleep(100)  ; Wait to see if paste worked
        if (A_Index < 3) {
            Sleep(50)  ; Additional delay between retries
        }
        pasteSuccess := true
        break
    }

    ; Restore original clipboard
    A_Clipboard := clipBackup

    ; Notify the user of the result
    if (pasteSuccess) {
        TrayTip("Uppercase", "Text converted to uppercase", 1)
    } else {
        TrayTip("Uppercase", "Text converted. Check if paste worked.", 2)
    }
}
; ---------------------------Ctrl + key-------------------------------

^Numpad0:: ; Ctrl + Numpad 0 (NumLock on): Open Windows Terminal
{
    ; Open Windows Terminal via PATH (works for any user account when installed from the Store)
    Run "wt"
}

^NumpadIns:: ; Ctrl + Numpad 0 (NumLock off): Open Windows Terminal
{
    ; Open Windows Terminal via PATH (works for any user account when installed from the Store)
    Run "wt"
}

;---------------------------------------------------------------------

; FUNCTIONS

/**
 * @name paste
 * @description This function is used to paste data to the active window. It first backs up the current clipboard contents, pastes the data, and then restores the original clipboard contents. This is useful when you want to paste data without losing the current clipboard contents.
 * 
 * @param {string} data - The data to be pasted.
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

/**
 * @name markdownToHTML
 * @description Converts a given Markdown string to HTML.
 * 
 * @param {string} markdown - The Markdown string to be converted.
 * @return {string} The converted HTML string.
 */
markdownToHtml(markdown) {
    ; Define the temporary file path for the Markdown input
    tempFile := A_Temp . "\markdown_input.md"

    ; Delete the temporary file if it already exists
    if FileExist(tempFile)
        FileDelete(tempFile)

    ; Write the Markdown content to the temporary file
    FileAppend(markdown, tempFile)

    ; Construct the shell command to run the Python script for conversion
    shellCommand := Format('{1} /c python "{2}" < "{3}" > "{4}"'
        , A_ComSpec
        , ".\markdown_to_html.py"
        , tempFile
        , tempFile . ".html")

    ; Execute the shell command and wait for it to complete
    RunWait(shellCommand, , "Hide")

    ; Define the path for the HTML output file
    htmlFile := tempFile . ".html"

    ; Initialize an empty string to hold the HTML content
    local html := ""

    ; Read the HTML content from the output file if it exists
    if FileExist(htmlFile) {
        html := FileRead(htmlFile)
        ; Delete the HTML output file after reading its content
        FileDelete(htmlFile)
    }

    ; Return the converted HTML content
    return html
}

/**
 * @name runWaitOne
 * @description This function runs a command and captures the output in a single step.
 * 
 * @param command The command to run.
 * @param input The input to pass to the command.
 * @param output The variable to store the output in.
 */
runWaitOne(command, input, &output) {
    ; Run the command and capture the output
    shell := ComObject("WScript.Shell")
    exec := shell.Exec(command)
    exec.StdIn.Write(input)
    exec.StdIn.Close()
    while !exec.StdOut.AtEndOfStream
        output .= exec.StdOut.ReadAll()
}
