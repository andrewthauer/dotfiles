#
# Initialize python environment
#
# = https://github.com/pyenv/pyenv
#

export PYENV_ROOT="${XDG_DATA_HOME}/pyenv"

_pyenv_init() {
  # expensive operation
  eval "$(pyenv init - --no-rehash)"

  # Rehash in the background
  # (pyenv rehash &) 2> /dev/null
}

_pyenv_lazy_init() {
  unset -f "$0"

  # faster alternative to full 'pyenv init'
  export PYENV_SHELL="${CURRENT_SHELL:-$SHELL}"
  prepend_path "${PYENV_ROOT}/shims"

  # lazy initialize
  lazyfunc _pyenv_init pyenv
}

# Use asdf if installed
if [[ -d "${XDG_DATA_HOME}/asdf/plugins/python" ]]; then
  echo "using asdf" >/dev/null

# Load package manager installed pyenv into shell session
elif command_exists "pyenv"; then
  _pyenv_lazy_init

# Load manually installed pyenv into the shell session
elif [[ -s "${PYENV_ROOT}/bin/pyenv" ]]; then
  prepend_path "${PYENV_ROOT}/bin"
  _pyenv_lazy_init

# Return if requirements not found
elif ! command_exists "python"; then
  unset -f _pyenv_init
  return 1
fi

#
# XDG specifications
#

export PYTHONSTARTUP="${XDG_CONFIG_HOME}/python/pythonrc.py"
export PYLINTHOME="${XDG_CACHE_HOME}/pylint"
