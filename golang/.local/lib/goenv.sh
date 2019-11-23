#
# Initialize go environment
#
# - https://golang.org/
# - https://github.com/syndbg/goenv
#

export GOENV_ROOT="${XDG_DATA_HOME}/goenv"

_goenv_init() {
  # expensive operation
  eval "$(goenv init - --no-rehash)"

  # Rehash in the background
  # (goenv rehash &) 2> /dev/null
}

_goenv_lazy_init() {
  unset -f "$0"

  # faster alternative to full 'goenv init'
  export GOENV_SHELL="${CURRENT_SHELL:-$SHELL}"
  export GOENV_GOPATH_PREFIX="${GOENV_ROOT}/versions"
  prepend_path "${GOENV_ROOT}/shims"

  # lazy initialize
  lazyfunc _goenv_init goenv
}

# Use asdf if installed
if [[ -d "${XDG_DATA_HOME}/asdf/plugins/golang" ]]; then
  echo "using asdf" >/dev/null

# Load package manager installed goenv into shell session
elif command_exists "goenv"; then
  _goenv_lazy_init

# Load manually installed goenv into the shell session
elif [[ -s "${GOENV_ROOT}/bin/goenv" ]]; then
  prepend_path "${GOENV_ROOT}/bin"
  _goenv_lazy_init

# Return if requirements not found
else
  unset GOENV_ROOT
  unset -f _goenv_lazy_init
  unset -f _goenv_init
  return 1
fi
