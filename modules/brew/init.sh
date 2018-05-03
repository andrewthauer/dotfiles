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
alias brewc='brew cleanup'
alias brewC='brew cleanup --force'
alias brewi='brew install'
alias brewl='brew list'
alias brewo='brew outdated'
alias brews='brew search'
alias brewu='brew update && brew upgrade'
alias brewx='brew remove'
alias brew-uses="brew uses --installed"

# Homebrew Bundle
alias brewb="brew bundle --global"

# Homebrew Cask
alias cask='brew cask'
alias caskc='brew cask cleanup --outdated'
alias caskC='brew cask cleanup'
alias caski='brew cask install'
alias caskl='brew cask list'
alias casko='brew cask outdated'
alias casks='brew cask search'
alias caskx='brew cask uninstall'

# brew cask repair
brew_cask_repair() {
  outdated_cask="${1}"
  github_user="${GITHUB_USER}"

  cd "$(brew --repository)/Library/Taps/caskroom/homebrew-cask/Casks"
  cask-repair --pull origin --push $github_user $outdated_cask
}
