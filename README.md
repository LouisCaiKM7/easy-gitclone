# GitClone Tool

A cross-platform interactive tool for cloning Git repositories with a graphical folder selector.

## Features

- 📁 **Graphical folder browser** - Modern dialog centered on screen at 1/2 resolution
- 🔑 **SSH URL prompt** - Easy input for Git SSH URLs
- ✅ **Auto-execute** - Runs git clone command automatically
- 🎨 **Colorful output** - Beautiful console feedback
- 🌍 **Cross-platform** - Works on Windows, macOS, and Linux

## Platform Support

- **Windows**: PowerShell script with WinForms dialog (`gitclone.bat`)
- **macOS**: Bash script with native macOS dialog (`gitclone.sh`)
- **Linux**: Bash script with zenity/kdialog support (`gitclone.sh`)

## Installation

### Windows

#### Option 1: Add to PATH (Recommended)

1. Add `E:\0_projects\gitclone` to your system PATH environment variable
2. Open a new terminal and type `gitclone` from anywhere

#### Option 2: Create an Alias

Add this to your PowerShell profile (`$PROFILE`):

```powershell
function gitclone { & "E:\0_projects\gitclone\gitclone.bat" }
```

#### Option 3: Run Directly

Navigate to the folder and run:
```
.\gitclone.bat
```

### macOS / Linux

1. Make the script executable:
```bash
chmod +x E:/0_projects/gitclone/gitclone.sh
```

2. Create an alias in your `~/.bashrc` or `~/.zshrc`:
```bash
alias gitclone='E:/0_projects/gitclone/gitclone.sh'
```

3. Or run directly:
```bash
./gitclone.sh
```

## Usage

1. Run `gitclone` (or `.\gitclone.bat`)
2. A folder browser dialog will appear - select your destination folder
3. Enter the Git SSH URL when prompted (e.g., `git@github.com:username/repo.git`)
4. The repository will be cloned to the selected location

## Requirements

- Git must be installed and available in PATH
- SSH keys must be configured for SSH cloning
- PowerShell execution policy must allow script execution

## Example

```
=== Git Clone Tool ===

Step 1: Select destination folder...
Selected destination: C:\Users\YourName\Projects

Step 2: Enter Git SSH URL
Example: git@github.com:username/repository.git
Git SSH URL: git@github.com:microsoft/vscode.git

=== Cloning Repository ===
URL: git@github.com:microsoft/vscode.git
Destination: C:\Users\YourName\Projects

Cloning into 'vscode'...
...

=== Clone Successful! ===
```
