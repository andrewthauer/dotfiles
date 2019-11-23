#
# Initialize ruby environment
#
# - https://github.com/rbenv/rbenv
#

export RBENV_ROOT="${XDG_DATA_HOME}/rbenv"

_rbenv_init() {
  # expensive operation
  eval "$(rbenv init - --no-rehash)"

  # Rehash in the background
  # (rbenv rehash &) 2> /dev/null
}

_rbenv_lazy_init() {
  unset -f "$0"

  # faster alternative to full 'rbenv init'
  export RBENV_SHELL="${CURRENT_SHELL:-$SHELL}"
  prepend_path "${RBENV_ROOT:-$HOME/.rbenv}/shims"

  # lazy initialize
  lazyfunc _rbenv_init rbenv
}

# Load package manager installed rbenv into shell session
if command_exists "rbenv"; then
  _rbenv_lazy_init

# Load manually installed rbenv into the shell session
elif [[ -s "${RBENV_ROOT}/bin/rbenv" ]]; then
  prepend_path "${RBENV_ROOT}/bin"
  _rbenv_lazy_init

# Return if requirements not found
else
  unset RBENV_ROOT
  unset -f _rbenv_lazy_init
  unset -f _rbenv_init
  return 1
fi
