# Reloads the current shell
alias reload='exec $SHELL'

# Directory listing
alias l='ls -1A'   # Lists in one column, hidden files.
alias ll='ls -alF' # Lists human readable sizes.
alias la='ll -a'   # Lists human readable sizes, hidden files.

# Clipboard
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
