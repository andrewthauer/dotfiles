#
# Initialize go module
#

GO_LAZY_TRIGGERS=(goenv go)

_goenv_init() {
  # expensive operation
  export GOENV_GOPATH_PREFIX="$HOME/.goenv/versions"
  eval "$(goenv init - --no-rehash)"
  unset GO_LAZY_TRIGGERS
}

# initialize goenv (lazy)
if command_exists "goenv"; then
  __lazyfunc _goenv_init "${GO_LAZY_TRIGGERS[@]}"
fi

if command_exists "go"; then
  # load aliases
  source "${DOTFILES_MODULES_DIR}/go/aliases.sh"
fi
