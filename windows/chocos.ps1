# =============================================
# Setup Chocolatey packages
# =============================================

"Install chocolatey"
iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex

# Install common chocolatey packages
choco install 7zip
choco install 7zip.commandline
choco install adobe-creative-cloud
choco install beyondcompare
choco install ConEmu
choco install firefox-dev
choco install git
choco install keepass
choco install keepass-plugin-favicon
choco install qttabbar
choco install sdelete
choco install steam
choco install velocity
choco install VisualStudioCode
