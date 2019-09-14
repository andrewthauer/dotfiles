#
# Initialize homebrew environment
#
# - https://brew.sh
# - https://docs.brew.sh/Homebrew-on-Linux
#

# linuxbrew initialization (if applicable)
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
