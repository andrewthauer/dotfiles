#
# Homebrew
#

# Homebrew
alias brewc="brew cleanup"
alias brewi="brew install"
alias brewu="brew uninstall"
alias brewl="brew list"
alias brewo="brew outdated"
alias brewr="brew remove"
alias brews="brew search"
alias brewupg="brew update && brew upgrade"
alias brewuses="brew uses --installed"

# Homebrew Bundle
alias brewb="brew bundle --global"
alias brewbh="brewb --help"
alias brewbi="brewb install"
alias brewbl="brewb list"

# Homebrew Cask
alias cask="brew cask"
alias caskc="brew cask cleanup --outdated"
alias caskC="brew cask cleanup"
alias caski="brew cask install"
alias caskl="brew cask list"
alias casko="brew cask outdated"
alias casks="brew cask search"
alias caskx="brew cask uninstall"

# Composite aliases
alias brew-upgrade="brew update && brew upgrade"
alias brew-clean="brew cleanup && brew cask cleanup"
