#
# Initialize python environment
#
# = https://github.com/pyenv/pyenv
#

PYTHON_LAZY_TRIGGERS=(python python2 python3 pip pip2 pip3)

_pyenv_init() {
  # expensive operation
  eval "$(pyenv init - --no-rehash)"
}

# initialize pyenv (lazy)
if command_exists "pyenv"; then
  lazyfunc _pyenv_init "${PYTHON_LAZY_TRIGGERS[@]}"
else
  unset -f _pyenv_init
fi

unset PYTHON_LAZY_TRIGGERS
