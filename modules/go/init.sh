#
# Initialize go module
#

_goenv_init() {
  # expensive function call
  eval "$(goenv init - --no-rehash)"
  unset -f "$0"
}

_goenv_lazy_init() {
  triggers=(goenv go)
  for cmd in "${triggers[@]}"; do
    eval "${cmd}() { unset -f ${triggers}; _goenv_init; ${cmd} \$@; }"
  done

  unset -f "$0"
}

# initialize goenv (lazy)
if command_exists "goenv"; then
  _goenv_lazy_init
fi

if command_exists "go"; then
  # load aliases
  source "${DOTFILES_MODULES_DIR}/go/aliases.sh"
fi
