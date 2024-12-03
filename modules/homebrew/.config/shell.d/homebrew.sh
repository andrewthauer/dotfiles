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
# Aliases
#

# Dependencies
alias brew-deps='brew deps --installed'
alias brew-leaves='brew leaves'
alias brew-uses='brew uses --installed'

# Composite aliases
alias brew-upgrade='brew update && brew upgrade && brew bundle && brew cleanup'
