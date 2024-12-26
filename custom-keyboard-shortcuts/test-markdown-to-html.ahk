#Include custom-keyboard-shortcuts.ahk

; Sample Markdown string
markdown := "
(
# Heading 1
## Heading 2
**Bold Text**
*Italic Text*

- List Item 1
- List Item 2
)"

; Convert Markdown to HTML
html := markdownToHtml(markdown)

; Write the result to a text file
if FileExist("output.html") {
    FileDelete("output.html")
}
FileAppend(html, "output.html")