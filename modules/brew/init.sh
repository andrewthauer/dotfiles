#
# Homebew helpers & aliases
#

# Skip if homebrew is not installed
if [[ ! -x "$(command -v brew)" ]]; then
  return
fi

#
# Aliases
#

# Homebrew
alias brewc="brew cleanup"
alias brewC="brew cleanup --force"
alias brewi="brew install"
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
alias brew-upgrade="brew update && brew bundle --global"
alias brew-clean="brew cleanup && brew cask cleanup"

# brew cask repair
brew_cask_repair() {
  outdated_cask="${1}"
  github_user="${GITHUB_USER}"

  cd "$(brew --repository)/Library/Taps/caskroom/homebrew-cask/Casks"
  cask-repair --pull origin --push $github_user $outdated_cask
}
