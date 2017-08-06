# =========================================================
# Run windows setup script (via PowerShell)
# =========================================================

""
"=== Running Setup for Windows ==="
""

# ---------------------------------------------------------
# Setup common variables

$currentDir = $PSScriptRoot
$dotfilesDir = Join-Path $currentDir "..\..\" -Resolve
$appDataDir = $env:APPDATA
$documentsDir = [Environment]::GetFolderPath("MyDocuments")

function SymlinkItem ($linkDir, $targetDir) {
  if (Test-Path "$linkDir" -PathType container) {
    cmd "/c rmdir $linkDir"
  }
  elseif (Test-Path "$linkDir") {
    Remove-Item "$linkDir"
  }

  New-Item -Path "$linkDir" -ItemType SymbolicLink -Value "$targetDir"
}

# ---------------------------------------------------------
# Symlink Settings

$powershellDir = Join-Path "$documentsDir" "WindowsPowerShell"

# PowerShell - profile.ps1
"Symlinking WindowsPowerShell\profile.ps1"
SymlinkItem "$powershellDir\profile.ps1" "$dotfilesDir\powershell\profile.ps1"

# PowerShell - cmdlets
"Symlinking WindowsPowerShell\cmdlets"
SymlinkItem "$powershellDir\cmdlets" "$dotfilesDir\powershell\cmdlets"

# ---------------------------------------------------------
# Install Chocolatey & packages

# .\chocos.ps1
