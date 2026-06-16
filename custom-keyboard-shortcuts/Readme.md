# AutoHotkey Scripts

This repository contains various AutoHotkey scripts for custom keyboard shortcuts and Markdown to HTML conversion.

## Files

- `custom-keyboard-shortcuts.ahk`: Contains custom keyboard shortcuts for various tasks.
- `test-markdown-to-html.ahk`: Script to test the Markdown to HTML conversion.
- `markdown_to_html.py`: Python script to convert Markdown text to HTML.

## Usage

### Custom Keyboard Shortcuts

The `custom-keyboard-shortcuts.ahk` script defines several keyboard shortcuts for common tasks:

- **Ctrl + Shift + D**: Paste the current date and time.
- **Ctrl + Shift + T**: Paste the current time.
- **Ctrl + Alt + M**: Convert Markdown to HTML and copy to clipboard.
   - Uses the `markdown_to_html.py` script to convert Markdown text to HTML using the Python `markdown` library.
- **Ctrl + Numpad 0 (NumLock on)**: Open Windows Terminal.
- **Ctrl + Numpad 0 (NumLock off)**: Open Windows Terminal.

### Markdown to HTML Conversion

Use the **Ctrl + Alt + M** shortcut to convert Markdown text to HTML:

1. Copy your Markdown text to the clipboard.
2. Press **Ctrl + Alt + M**.
3. The converted HTML is placed back on the clipboard.
4. Paste the result wherever you need it. A tray notification confirms when the HTML is ready.

The conversion is performed by `markdown_to_html.py` using the Python `markdown` library. The script is invoked via `cmd.exe` and reads from / writes to a temporary file in `%TEMP%`.

**Prerequisites:**
- Python must be on `PATH`.
- The `markdown` library must be installed:
  ```sh
  pip install markdown
  ```


### Functions

#### `paste(data)`

This function pastes data to the active window while preserving the current clipboard contents.

#### `markdownToHtml(markdown)`

This function converts a given Markdown string to HTML using a Python script.

#### `runWaitOne(command, input, &output)`

This function runs a command and captures the output in a single step.

## Requirements

- AutoHotkey v2.0
- Python with the `markdown` library

## Installation

1. Install [AutoHotkey v2.0](https://www.autohotkey.com/).
2. Install Python and the `markdown` library:
   ```sh
   pip install markdown
   ```
3. Clone the repo 

## License

This project is licensed under the MIT License.
