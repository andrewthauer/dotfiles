#
# Initialize ruby module
#

RUBY_LAZY_TRIGGERS=(rbenv ruby bundle rake)

_rbenv_init() {
  # cleanup
  unset -f $0
  unset -f ${RUBY_LAZY_TRIGGERS[@]}
  unset RUBY_LAZY_TRIGGERS

  # expensive operation
  eval "$(rbenv init - --no-rehash)"
}

_rbenv_lazy_init() {
  triggers=($@)
  for cmd in "${triggers[@]}"; do
    eval "${cmd}() { _rbenv_init; ${cmd} \$@; }"
  done
  unset -f $0
}

# initialize rbenv (lazy)
if command_exists "rbenv"; then
  _rbenv_lazy_init "${RUBY_LAZY_TRIGGERS[@]}"
fi

if command_exists "ruby"; then
  # load aliases
  source "${DOTFILES_MODULES_DIR}/ruby/aliases.sh"
fi
