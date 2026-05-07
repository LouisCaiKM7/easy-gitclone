#!/bin/bash
# GitClone Tool - Interactive Git Clone with Folder Selection
# Platform: Linux/macOS (Bash)
# Usage: Run this script to clone a git repository to a selected destination

echo -e "\033[1;36m=== Git Clone Tool ===\033[0m"
echo ""

# Function to select folder based on available tools
select_folder() {
    local selected_path=""
    
    # Try zenity (common on Linux with GNOME)
    if command -v zenity &> /dev/null; then
        selected_path=$(zenity --file-selection --directory --title="📁 Select Destination Folder for Git Clone" 2>/dev/null)
        echo "$selected_path"
        return
    fi
    
    # Try kdialog (common on Linux with KDE)
    if command -v kdialog &> /dev/null; then
        selected_path=$(kdialog --getexistingdirectory "$HOME" --title "📁 Select Destination Folder for Git Clone" 2>/dev/null)
        echo "$selected_path"
        return
    fi
    
    # Try osascript (macOS)
    if command -v osascript &> /dev/null; then
        selected_path=$(osascript -e 'tell application "System Events"' -e 'activate' -e 'set folderPath to choose folder with prompt "📁 Select Destination Folder for Git Clone"' -e 'return POSIX path of folderPath' -e 'end tell' 2>/dev/null | tr -d '\n')
        echo "$selected_path"
        return
    fi
    
    # Fallback: manual input
    echo -e "\033[1;33mNo GUI dialog available. Please enter path manually.\033[0m"
    read -p "Destination folder path: " selected_path
    
    # Expand ~ to home directory
    selected_path="${selected_path/#\~/$HOME}"
    
    echo "$selected_path"
}

# Get destination folder
echo -e "\033[1;33mStep 1: Select destination folder...\033[0m"
destination=$(select_folder)

if [ -z "$destination" ]; then
    echo -e "\033[1;31mNo folder selected. Exiting.\033[0m"
    exit 1
fi

# Verify destination exists
if [ ! -d "$destination" ]; then
    echo -e "\033[1;31mError: Directory does not exist: $destination\033[0m"
    exit 1
fi

echo -e "\033[1;32mSelected destination: $destination\033[0m"
echo ""

# Get Git SSH URL
echo -e "\033[1;33mStep 2: Enter Git SSH URL\033[0m"
echo -e "\033[0;37mExample: git@github.com:username/repository.git\033[0m"
read -p "Git SSH URL: " git_url

if [ -z "$git_url" ]; then
    echo -e "\033[1;31mNo URL provided. Exiting.\033[0m"
    exit 1
fi

echo ""
echo -e "\033[1;36m=== Cloning Repository ===\033[0m"
echo -e "\033[1;37mURL: $git_url\033[0m"
echo -e "\033[1;37mDestination: $destination\033[0m"
echo ""

# Execute git clone
cd "$destination" || exit 1
git clone "$git_url"

if [ $? -eq 0 ]; then
    echo ""
    echo -e "\033[1;32m=== Clone Successful! ===\033[0m"
else
    echo ""
    echo -e "\033[1;31m=== Clone Failed ===\033[0m"
    echo -e "\033[1;33mPlease check the URL and your SSH keys configuration.\033[0m"
fi

echo ""
read -p "Press Enter to exit..."
