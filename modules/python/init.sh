#
# Initialize python module
#

PYTHON_LAZY_TRIGGERS=(python python2 python3 pip pip2 pip3)

_pyenv_init() {
  # expensive operation
  eval "$(pyenv init - --no-rehash)"
  unset PYTHON_LAZY_TRIGGERS
}

# initialize pyenv (lazy)
if command_exists "pyenv"; then
  __lazyfunc _pyenv_init "${PYTHON_LAZY_TRIGGERS[@]}"
fi

if command_exists "python"; then
  # load aliases
  source "${DOTFILES_MODULES_DIR}/python/aliases.sh"
fi
