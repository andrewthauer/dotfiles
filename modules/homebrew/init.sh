#
# Initialize brew module
#

# linuxbrew initialization (if applicable)
if [[ "$OSTYPE" == linux* ]]; then
  # add brew to path
  test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
  test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)

  # initialize brew
  if [[ -x "$(command -v brew)" ]]; then
    eval $($(brew --prefix)/bin/brew shellenv)
  fi
fi

# load aliases
if [[ -x "$(command -v brew)" ]]; then
  source "${DOTFILES_MODULES_DIR}/homebrew/aliases.sh"
fi
