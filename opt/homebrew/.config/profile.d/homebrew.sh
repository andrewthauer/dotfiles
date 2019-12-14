#
# Setup homebrew environment
#

# Set brew prefix if macos to avoid using "$(brew --prefix)"
if [[ "$OSTYPE" == darwin* ]]; then
  BREW_PREFIX="${BREW_PREFIX:-/usr/local}"

# Linuxbrew initialization (if applicable)
elif [[ "$OSTYPE" == linux* ]]; then
  if [[ -x "$(command -v brew)" ]]; then
    [[ -z ${BREW_PREFIX} ]] && BREW_PREFIX="$(brew --prefix)"
    eval $(${BREW_PREFIX}/bin/brew shellenv)
  elif [[ -d "/home/linuxbrew/.linuxbrew" ]]; then
    eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
  elif [[ -d "~/.linuxbrew" ]]; then
    eval $(~/.linuxbrew/bin/brew shellenv)
  fi
fi
