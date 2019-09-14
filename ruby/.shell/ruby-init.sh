#
# Initialize ruby environment
#
# - https://github.com/rbenv/rbenv
#

RUBY_LAZY_TRIGGERS=(rbenv ruby bundle rake)

_rbenv_init() {
  # expensive operation
  eval "$(rbenv init - --no-rehash)"
}

# initialize rbenv (lazy)
if command_exists "rbenv"; then
  lazyfunc _rbenv_init "${RUBY_LAZY_TRIGGERS[@]}"
else
  unset -f _rbenv_init
fi

unset RUBY_LAZY_TRIGGERS
