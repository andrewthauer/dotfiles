#
# Initialize node environment
#
# - https://github.com/nodenv/nodenv
#

export NODENV_ROOT="${XDG_DATA_HOME}/nodenv"

_nodenv_init() {
  # expensive operation
  eval "$(nodenv init - --no-rehash)"

  # Rehash in the background
  # (nodenv rehash &) 2> /dev/null"
}

_nodenv_lazy_init() {
  unset -f "$0"

  # faster alternative to full 'nodenv init'
  export NODENV_SHELL="${CURRENT_SHELL:-$SHELL}"
  prepend_path "${NODENV_ROOT}/shims"

  # lazy initialize
  lazyfunc _nodenv_init nodenv
}

# Load package manager installed nodenv into shell session
if command_exists "nodenv"; then
  _nodenv_lazy_init

# Load manually installed nodenv into the shell session
elif [[ -s "${NODENV_ROOT:-$HOME/.nodenv}/bin/nodenv" ]]; then
  prepend_path "${NODENV_ROOT}/bin"
  _nodenv_lazy_init

# Return if requirements not found
else
  unset NODENV_ROOT
  unset -f _nodenv_lazy_init
  unset -f _nodenv_init
  return 1
fi
