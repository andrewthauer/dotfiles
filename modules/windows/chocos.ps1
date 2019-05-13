# =============================================
# Setup Chocolatey packages
# =============================================

"Install chocolatey"
iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex

# Install common chocolatey packages
choco install 7zip
choco install 7zip.commandline
choco install beyondcompare
choco install firefox-dev
choco install git
choco install velocity
choco install VisualStudioCode
