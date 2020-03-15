#
# Initialize homebrew helpers
#
# - https://brew.sh
# - https://docs.brew.sh/Homebrew-on-Linux
#

# Check requirements
if ! command_exists "brew"; then
  return 1
fi

#
# Environment
#

# XDG specification
export HOMEBREW_BUNDLE_FILE="${XDG_CONFIG_HOME}/homebrew/Brewfile"

# Do not create a lock file
export HOMEBREW_BUNDLE_NO_LOCK

#
# Aliases
#

# Homebrew
alias brewc='brew cleanup'
alias brewi='brew install'
alias brewu='brew uninstall'
alias brewl='brew list'
alias brewo='brew outdated'
alias brewr='brew remove'
alias brews='brew search'

# Dependencies
alias brewdeps='brew deps --installed'
alias brewleaves='brew leaves'
alias brewuses='brew uses --installed'

# Homebrew Bundle
alias brewb='brew bundle'
alias brewbl='brewb list'

# Homebrew Cask
alias cask='brew cask'
alias caski='brew cask install'
alias caskl='brew cask list'
alias casko='brew cask outdated'
alias casks='brew cask search'
alias caskx='brew cask uninstall'

# Composite aliases
alias brew-upgrade='brew update && brew bundle && brew cleanup'
alias brew-clean='brew cleanup && brew cask cleanup'
