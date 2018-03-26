#
# Windows Setup
#

""
"=== Running Setup for Windows ==="
""

# Common variables
$dotfilesDir = Join-Path -Resolve $PSScriptRoot "../.."
$documentsDir = [Environment]::GetFolderPath("MyDocuments")
$powershellDir = Join-Path "$documentsDir" "WindowsPowerShell"

#
# Symlink Settings
#

source $dotfilesDir/modules/powershell/functions/symlink-item.ps1

# PowerShell profile
"Symlinking WindowsPowerShell\profile.ps1"
Symlink-Item "$powershellDir\profile.ps1" "$dotfilesDir\config\powershell/profile.ps1"

#
# Install Chocolatey & packages
#

$PSScriptRoot\chocos.ps1
