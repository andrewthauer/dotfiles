# --------------------------------------------------------------
# Common shell aliases
# --------------------------------------------------------------

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
alias l='ls -1A'       # Lists in one column, hidden files.
alias ll='ls -alF'     # Lists human readable sizes.
alias lr='ll -R'       # Lists human readable sizes, recursively.
alias la='ll -a'       # Lists human readable sizes, hidden files.
alias lm='la | $PAGER' # Lists human readable sizes, hidden files through pager.
alias lx='ll -XB'      # Lists sorted by extension (GNU only).
alias lk='ll -Sr'      # Lists sorted by size, largest last.
alias lt='ll -tr'      # Lists sorted by date, most recent last.
alias lc='lt -c'       # Lists sorted by date, most recent last, shows change time.
alias lu='lt -u'       # Lists sorted by date, most recent last, shows access time.

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
