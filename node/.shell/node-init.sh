#
# Initialize node environment
#
# - https://github.com/nodenv/nodenv
#

NODE_LAZY_TRIGGERS=(nodenv node npm npx yarn)

_nodenv_init() {
  unset NODE_LAZY_TRIGGERS
  # expensive operation
  eval "$(nodenv init - --no-rehash)"
}

# initialize nodenv (lazy)
if command_exists "nodenv"; then
  lazyfunc _nodenv_init "${NODE_LAZY_TRIGGERS[@]}"
else
  unset NODE_LAZY_TRIGGERS
  unset -f _nodenv_init
fi
