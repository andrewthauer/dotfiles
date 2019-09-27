#
# Initialize go environment
#
# - https://golang.org/
# - https://github.com/syndbg/goenv
#

export GOENV_ROOT="${XDG_DATA_HOME}/goenv"

_goenv_init() {
  # expensive operation
  # eval "$(goenv init - --no-rehash)"

  # faster alternative to `goenv init`
  export GOENV_SHELL="${SHELL}"
  export GOENV_GOPATH_PREFIX="${GOENV_ROOT}/versions"
  export PATH="${GOENV_ROOT}/shims:${PATH}"

  # Rehash in the background
  # (goenv rehash &) 2> /dev/null

  unset -f "$0"
}

# Load package manager installed goenv into shell session
if command_exists "goenv"; then
  _goenv_init

# Load manually installed goenv into the shell session
elif [[ -s "${GOENV_ROOT}/bin/goenv" ]]; then
  export PATH="${GOENV_ROOT}/bin:${PATH}"
  _goenv_init

# Return if requirements not found
elif ! command_exists "go"; then
  unset -f _goenv_init
  return 1
fi
