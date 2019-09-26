#
# Initialize node environment
#
# - https://github.com/nodenv/nodenv
#

NODE_LAZY_TRIGGERS=(nodenv node npm npx yarn)

_nodenv_init() {
  # expensive operation
  eval "$(nodenv init - --no-rehash)"
}

# initialize nodenv (lazy)
if command_exists "nodenv"; then
  lazyfunc _nodenv_init "${NODE_LAZY_TRIGGERS[@]}"
  unset NODE_LAZY_TRIGGERS
else
  unset -f _nodenv_init
fi

#
# Aliases
#

if ! command_exists "node"; then
  return 1
fi

# npm list
alias npm-list="npm list --depth=0 2>/dev/null"
alias npm-list-g="npm list -g --depth=0 2>/dev/null"

# npm outdated
alias npm-outdated="npm outdated --depth 0 -q"
alias npm-outdated-g="npm outdated -g --depth 0 -q"

# nodenv
alias nodenv-alias="nodenv alias"
alias nodenv-dpi="nodenv default-packages install --all"
