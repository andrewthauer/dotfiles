#
# Common shell aliases
#

# Go to the dotfiles directory
[[ -n "${DOTFILES_DIR}" ]] && alias dotdir="cd ${DOTFILES_DIR}"

#
# General
#

# Reloads the current shell
alias reload="exec $SHELL -l"

# Clear the screen
alias clr="clear"

#
# Directories
#

# Listing
alias l="ls -1A"         # Lists in one column, hidden files.
alias ll="ls -lh"        # Lists human readable sizes.
alias lr="ll -R"         # Lists human readable sizes, recursively.
alias la="ll -a"         # Lists human readable sizes, hidden files.
alias lm="la | $PAGER"   # Lists human readable sizes, hidden files through pager.
alias lx="ll -XB"        # Lists sorted by extension (GNU only).
alias lk="ll -Sr"        # Lists sorted by size, largest last.
alias lt="ll -tr"        # Lists sorted by date, most recent last.
alias lc="lt -c"         # Lists sorted by date, most recent last, shows change time.
alias lu="lt -u"         # Lists sorted by date, most recent last, shows access time.

# Directory stack
alias d="dirs -v"

# Find from relative pwd
alias findhere="find . -name"

#
# Resource Usage
#

alias df="df -kh"
alias du="du -kh"

if [[ "$OSTYPE" == darwin* || "$OSTYPE" == *bsd* ]]; then
  alias topc="top -o cpu"
  alias topm="top -o vsize"
else
  alias topc="top -o %CPU"
  alias topm="top -o %MEM"
fi

# Displays process with grep
function psg() {
  ps aux | { head -1; grep -v grep | grep -i "$1"; }
}

# Displays user owned processes status.
function psu() {
  ps -U "${1:-$LOGNAME}" -o "pid,%cpu,%mem,command" "${(@)argv[2,-1]}"
}

#
# Networking
#

# list all tcp ports
alias lstcp="lsof -i -n -P | grep TCP"

#
# Clipboard
#

# macOS open everywhere
if [[ "$OSTYPE" == darwin* ]]; then
  alias o="open"
else
  alias o="xdg-open"

  if [[ -x "$(command -v xclip)" ]]; then
    alias pbcopy="xclip -selection clipboard -in"
    alias pbpaste="xclip -selection clipboard -out"
  elif [[ -x "$(command -v xsel)" ]]; then
    alias pbcopy="xsel --clipboard --input"
    alias pbpaste="xsel --clipboard --output"
  fi
fi

alias pbc="pbcopy"
alias pbp="pbpaste"

#
# File Download
#

wget() {
  # Override the wgetrc location
  export WGETRC="${XDG_CONFIG_HOME}/wgetrc"
  unset -f "$0"
  wget $@
}

get() {
  if [[ -x "$(command -v curl)" ]]; then
    curl --continue-at - --location --progress-bar --remote-name --remote-time
  elif [[ -x "$(command -v wget)" ]]; then
    wget --continue --progress=bar --timestamping
  fi
}

#
# Archives
#

# untar a file
untar() {
  [[ -n "$2" ]] && mkdir -p $2
  tar -xf $1 -C ${2:-.}
}

#
# Miscellaneous
#

# Serves a directory via HTTP
http-serve() {
  if [[ -x $(command -v python3) ]]; then
    python3 -m http.server
  else
    python -m SimpleHTTPServer
  fi
}
