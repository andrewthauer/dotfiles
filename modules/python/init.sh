#
# Initialize python module
#

_pyenv_init() {
  # expensive function call
  eval "$(pyenv init - --no-rehash)"
  unset -f "$0"
}

_pyenv_lazy_init() {
  triggers=(pyenv python python2 python3 pip pip2 pipe3)
  for cmd in "${triggers[@]}"; do
    eval "${cmd}() { unset -f ${triggers}; _pyenv_init; ${cmd} \$@; }"
  done

  unset -f "$0"
}

# initialize pyenv (lazy)
if command_exists "pyenv"; then
  _pyenv_lazy_init
fi

if command_exists "python"; then
  # load aliases
  source "${DOTFILES_MODULES_DIR}/python/aliases.sh"
fi
