#
# Symlink-Item
#

function Symlink-Item ($linkDir, $targetDir) {
  if (Test-Path "$linkDir" -PathType container) {
    cmd "/c rmdir $linkDir"
  }
  elseif (Test-Path "$linkDir") {
    Remove-Item "$linkDir"
  }

  New-Item -Path "$linkDir" -ItemType SymbolicLink -Value "$targetDir"
}
