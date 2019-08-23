#
# Initialize ruby module
#

_rbenv_init() {
  # expensive function call
  eval "$(rbenv init - --no-rehash)"
  unset -f "$0"
}

_rbenv_lazy_init() {
  triggers=(rbenv ruby bundle rake)
  for cmd in "${triggers[@]}"; do
    eval "${cmd}() { unset -f ${triggers}; _rbenv_init; ${cmd} \$@; }"
  done

  unset -f "$0"
}

# initialize rbenv (lazy)
if command_exists "rbenv"; then
  _rbenv_lazy_init
fi

if command_exists "ruby"; then
  # load aliases
  source "${DOTFILES_MODULES_DIR}/ruby/aliases.sh"
fi
