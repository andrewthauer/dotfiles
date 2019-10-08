#
# Initialize homebrew environment
#
# - https://brew.sh
# - https://docs.brew.sh/Homebrew-on-Linux
#

# XDG specification
export HOMEBREW_BUNDLE_FILE="${XDG_CONFIG_HOME}/homebrew/Brewfile"

# Linuxbrew initialization (if applicable)
if [[ "$OSTYPE" == linux* ]]; then
  if [[ -x "$(command -v brew)" ]]; then
    [[ -z ${BREW_PREFIX} ]] && BREW_PREFIX="$(brew --prefix)"
    eval $(${BREW_PREFIX}/bin/brew shellenv)
  elif [[ -d "/home/linuxbrew/.linuxbrew" ]]; then
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
  elif [[ -d "~/.linuxbrew" ]]; then
    eval $(~/.linuxbrew/bin/brew shellenv)
  fi
fi

#
# Aliases
#

if ! command_exists "brew"; then
  return 1
fi

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
alias brewb="brew bundle"
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
