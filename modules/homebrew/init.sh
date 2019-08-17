#
# Initialize brew module
#

# linuxbrew initialization (if applicable)
if [[ "$OSTYPE" == linux* ]]; then
  # add brew to path
  test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
  test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

  [[ -z ${BREW_PREFIX} ]] && BREW_PREFIX="$(brew --prefix)"

  # initialize brew
  if [[ -x "$(command -v brew)" ]]; then
    eval $(${BREW_PREFIX}/bin/brew shellenv)
  fi
fi

# load aliases
if command_exists "brew"; then
  source "${DOTFILES_MODULES_DIR}/homebrew/aliases.sh"
fi
