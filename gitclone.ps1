# GitClone Tool - Interactive Git Clone with Folder Selection
# Usage: Run this script to clone a git repository to a selected destination
# Platform: Windows (PowerShell)

Add-Type -AssemblyName System.Windows.Forms

# Function to show folder browser dialog
function Select-Folder {
    $folderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
    $folderBrowser.Description = "Select Destination Folder for Git Clone"
    $folderBrowser.RootFolder = [System.Environment+SpecialFolder]::MyComputer
    $folderBrowser.ShowNewFolderButton = $true
    
    $result = $folderBrowser.ShowDialog()
    
    if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
        return $folderBrowser.SelectedPath
    }
    else {
        return $null
    }
}

# Main script
Write-Host "=== Git Clone Tool ===" -ForegroundColor Cyan
Write-Host ""

# Get destination folder
Write-Host "Step 1: Select destination folder..." -ForegroundColor Yellow
$destination = Select-Folder

if (-not $destination) {
    Write-Host "No folder selected. Exiting." -ForegroundColor Red
    exit 1
}

Write-Host "Selected destination: $destination" -ForegroundColor Green
Write-Host ""

# Get Git SSH URL
Write-Host "Step 2: Enter Git SSH URL" -ForegroundColor Yellow
Write-Host "Example: git@github.com:username/repository.git" -ForegroundColor Gray
$gitUrl = Read-Host "Git SSH URL"

if ([string]::IsNullOrWhiteSpace($gitUrl)) {
    Write-Host "No URL provided. Exiting." -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "=== Cloning Repository ===" -ForegroundColor Cyan
Write-Host "URL: $gitUrl" -ForegroundColor White
Write-Host "Destination: $destination" -ForegroundColor White
Write-Host ""

# Execute git clone
try {
    Set-Location $destination
    git clone $gitUrl
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "=== Clone Successful! ===" -ForegroundColor Green
    }
    else {
        Write-Host ""
        Write-Host "=== Clone Failed ===" -ForegroundColor Red
        Write-Host "Please check the URL and your SSH keys configuration." -ForegroundColor Yellow
    }
}
catch {
    Write-Host "Error: $_" -ForegroundColor Red
}

Write-Host ""
Write-Host "Press any key to exit..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
