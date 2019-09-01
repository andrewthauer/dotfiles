#
# Initialize go module
#

GO_LAZY_TRIGGERS=(goenv go)

_goenv_init() {
  # cleanup
  unset -f $0
  unset -f ${GO_LAZY_TRIGGERS[@]}
  unset GO_LAZY_TRIGGERS

  # expensive operation
  export GOENV_GOPATH_PREFIX="$HOME/.goenv/versions"
  eval "$(goenv init - --no-rehash)"
}

_goenv_lazy_init() {
  triggers=($@)
  for cmd in "${triggers[@]}"; do
    eval "${cmd}() { _goenv_init; ${cmd} \$@; }"
  done
  unset -f $0
}

# initialize goenv (lazy)
if command_exists "goenv"; then
  _goenv_lazy_init "${GO_LAZY_TRIGGERS[@]}"
fi

if command_exists "go"; then
  # load aliases
  source "${DOTFILES_MODULES_DIR}/go/aliases.sh"
fi
