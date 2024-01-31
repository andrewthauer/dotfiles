# --------------------------------------------------------------
# Common shell aliases
# --------------------------------------------------------------

#
# General
#

# Reloads the current shell
alias reload='exec $SHELL'

# Clear the screen
alias clr='clear'

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

# Directory stack
alias d='dirs -v'

# Find from relative pwd
alias findhere='find . -name'

#
# Resource Usage
#

# Disk usage
alias df='df -kh'
alias du='du -kh'
alias du1='du -kh -d1'
alias du1s='du1 | sort -h'

# Memory & cpu
if [[ "$OSTYPE" == darwin* || "$OSTYPE" == *bsd* ]]; then
  alias topc='top -o cpu'
  alias topm='top -o vsize'
else
  alias topc='top -o %CPU'
  alias topm='top -o %MEM'
fi

# Displays process with grep
function psg() {
  ps aux | {
    head -1
    grep -v grep | grep -i "$1"
  }
}

#
# encoding / decoding
#

alias b64dec="base64 --decode"

#
# Networking
#

# list all tcp ports
alias lstcp='lsof -i -n -P | grep TCP'

#
# Clipboard
#

# macOS open everywhere
if [[ "$OSTYPE" == darwin* ]]; then
  alias o='open'
else
  alias open='xdg-open'
  alias o='open'

  if [[ -x "$(command -v xclip)" ]]; then
    alias pbcopy='xclip -selection clipboard -in'
    alias pbpaste='xclip -selection clipboard -out'
  elif [[ -x "$(command -v xsel)" ]]; then
    alias pbcopy='xsel --clipboard --input'
    alias pbpaste='xsel --clipboard --output'
  fi
fi

alias pbc='pbcopy'
alias pbp='pbpaste'

#
# Archives
#

# untar a file
untar() {
  [[ -n "$2" ]] && mkdir -p "$2"
  tar -xf "$1" -C "${2:-.}"
}

#
# Http Serving
#

# Serves a directory via HTTP
http-serve() {
  if [[ -x $(command -v python3) ]]; then
    python3 -m http.server
  else
    python -m SimpleHTTPServer
  fi
}
