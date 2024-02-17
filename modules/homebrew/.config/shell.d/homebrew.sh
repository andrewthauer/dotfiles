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

# No dev hints
export HOMEBREW_NO_ENV_HINTS

#
# Aliases
#

# Homebrew
alias brewb='brew bundle'
alias brewc='brew cleanup'
alias brewi='brew install'
alias brewl='brew list'
alias brewo='brew outdated'
alias brewr='brew remove'
alias brews='brew search'
alias brewu='brew uninstall'

# Dependencies
alias brew-deps='brew deps --installed'
alias brew-leaves='brew leaves'
alias brew-uses='brew uses --installed'

# Composite aliases
alias brew-upgrade='brew update && brew upgrade && brew bundle && brew cleanup'
