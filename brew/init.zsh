#
# Homebew helpers & aliases
#

brew_cask_setup_repair() {
  # fork homebrew-cask to your account - only needed once
  cd "$(brew --repository)/Library/Taps/caskroom/homebrew-cask/Casks"
  hub fork
}

brew_cask_repair() {
  # use to update <outdated_cask>
  outdated_cask=$1 # '<the-cask-i-want-to-update>'
  github_user=${GITHUB_USER} # '<my-github-username>'

  cd "$(brew --repository)/Library/Taps/caskroom/homebrew-cask/Casks"
  cask-repair --pull origin --push $github_user $outdated_cask
}

# aliases
alias brew-uses="brew uses --installed"
