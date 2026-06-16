# AutoHotkey Scripts

A collection of AutoHotkey v2 scripts for Windows that add custom keyboard shortcuts and productivity utilities.

## Requirements

- [AutoHotkey v2.0](https://www.autohotkey.com/) — these scripts target AHK v2 exclusively and are not compatible with AHK v1.
- Python 3 (required by the Markdown-to-HTML feature) with the `markdown` library:
  ```sh
  pip install markdown
  ```

## Scripts

### [`custom-keyboard-shortcuts/`](custom-keyboard-shortcuts/)

The main script collection. See [`custom-keyboard-shortcuts/Readme.md`](custom-keyboard-shortcuts/Readme.md) for full documentation.

**Shortcuts at a glance:**

| Shortcut | Action |
|---|---|
| `Ctrl + Shift + D` | Paste the current date and time |
| `Ctrl + Shift + T` | Paste the current time |
| `Ctrl + Alt + M` | Convert clipboard Markdown to HTML |
| `Ctrl + Numpad 0` | Open Windows Terminal |
| `CapsLock` (hold) | Hyper key (Ctrl + Shift + Alt) |
| `Hyper + H` | Convert selected text to UPPERCASE and paste |

## Installation

1. Install [AutoHotkey v2.0](https://www.autohotkey.com/).
2. Clone this repository:
   ```sh
   git clone https://github.com/J-MaFf/AutoHotkey-Scripts.git
   ```
3. (Optional) Install Python dependencies for Markdown conversion:
   ```sh
   pip install markdown
   ```
4. Double-click `custom-keyboard-shortcuts/custom-keyboard-shortcuts.ahk` to run, or add it to your Windows startup folder.

## License

MIT
