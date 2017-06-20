# =============================================
# Setup Chocolatey packages
# =============================================

"Install chocolatey"
iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex

# -------------------------------------------
# Install common chocolatey packages

choco install 7zip
choco install 7zip.commandline
choco install ConEmu
choco install git
choco install qttabbar

# -------------------------------------------
# Install util chocolatey packages

# choco install sdelete
# choco install testdisk
# choco install testdisk-photorec

# -------------------------------------------
# Install app chocolatey packages

choco install adobe-creative-cloud
choco install Atom
choco install beyondcompare
choco install firefox-dev
choco install keepass
choco install keepass-plugin-favicon
choco install steam
choco install velocity
choco install VisualStudioCode
