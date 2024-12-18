#
# Common aliases
#

# Go to the dotfiles directory
if [ -n "${DOTFILES_DIR}" ]; then
  alias dotdir='cd ${DOTFILES_DIR}'
fi

#
# General
#

# Reloads the current shell
alias reload='exec $SHELL'

# Make sudo work with aliases
# https://unix.stackexchange.com/questions/148545/why-does-sudo-ignore-aliases
alias sudo='sudo '

#
# Directories
#

# Listing
alias l='ls -1A'   # Lists in one column, hidden files.
alias ll='ls -alF' # Lists human readable sizes.
alias la='ll -a'   # Lists human readable sizes, hidden files.

#
# encoding / decoding
#

alias b64dec="base64 --decode"

#
# Clipboard
#

# macOS open everywhere
if [[ "$OSTYPE" == darwin* ]]; then
  alias o='open'
else
  alias open='xdg-open'
  alias o='open'

  if [ -x "$(command -v xclip)" ]; then
    alias pbcopy='xclip -selection clipboard -in'
    alias pbpaste='xclip -selection clipboard -out'
  elif [ -x "$(command -v xsel)" ]; then
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
  fi
fi
