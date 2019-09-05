#
# Initialize go environment
#
# - https://golang.org/
# - https://github.com/syndbg/goenv
#

GO_LAZY_TRIGGERS=(goenv go)

_goenv_init() {
  unset GO_LAZY_TRIGGERS
  # expensive operation
  export GOENV_GOPATH_PREFIX="$HOME/.goenv/versions"
  eval "$(goenv init - --no-rehash)"
}

# initialize goenv (lazy)
if command_exists "goenv"; then
  lazyfunc _goenv_init "${GO_LAZY_TRIGGERS[@]}"
else
  unset GO_LAZY_TRIGGERS
  unset -f _goenv_init
fi
