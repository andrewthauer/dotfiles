#
# Initialize python environment
#
# = https://github.com/pyenv/pyenv
#

export PYENV_ROOT="${XDG_DATA_HOME}/pyenv"

_pyenv_init() {
  # expensive operation
  # eval "$(pyenv init - --no-rehash)"

  # faster alternative to `pyenv init`
  export PYENV_SHELL="${SHELL}"
  export PATH="${PYENV_ROOT}/shims:${PATH}"

  # Rehash in the background
  # (pyenv rehash &) 2> /dev/null

  unset -f "$0"
}

# Load package manager installed pyenv into shell session
if command_exists "pyenv"; then
  _pyenv_init

# Load manually installed pyenv into the shell session
elif [[ -s "${PYENV_ROOT}/bin/pyenv" ]]; then
  export PATH="${PYENV_ROOT}/bin:${PATH}"
  _pyenv_init

# Return if requirements not found
elif ! command_exists "python"; then
  unset -f _pyenv_init
  return 1
fi
