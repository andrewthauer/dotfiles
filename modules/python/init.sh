#
# Initialize python module
#

PYTHON_LAZY_TRIGGERS=(python python2 python3 pip pip2 pip3)

_pyenv_init() {
  # cleanup
  unset -f $0
  unset -f ${PYTHON_LAZY_TRIGGERS[@]}
  unset PYTHON_LAZY_TRIGGERS

  # expensive operation
  eval "$(pyenv init - --no-rehash)"
}

_pyenv_lazy_init() {
  triggers=($@)
  for cmd in "${triggers[@]}"; do
    eval "${cmd}() { _pyenv_init; ${cmd} \$@; }"
  done
  unset -f $0
}

# initialize pyenv (lazy)
if command_exists "pyenv"; then
  _pyenv_lazy_init "${PYTHON_LAZY_TRIGGERS[@]}"
fi

if command_exists "python"; then
  # load aliases
  source "${DOTFILES_MODULES_DIR}/python/aliases.sh"
fi
