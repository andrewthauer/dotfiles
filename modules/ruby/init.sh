#
# Initialize ruby module
#

RUBY_LAZY_TRIGGERS=(rbenv ruby bundle rake)

_rbenv_init() {
  # expensive operation
  eval "$(rbenv init - --no-rehash)"
  unset -f $0
}

# initialize rbenv (lazy)
if command_exists "rbenv"; then
  __lazyfunc _rbenv_init "${RUBY_LAZY_TRIGGERS[@]}"
fi

if command_exists "ruby"; then
  # load aliases
  source "${DOTFILES_MODULES_DIR}/ruby/aliases.sh"
fi
