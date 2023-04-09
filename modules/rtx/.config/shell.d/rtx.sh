#
# Initialze asdf environment
#
# - https://github.com/asdf-vm/asdf
#

if ! command_exists "rtx"; then
  return 1
fi

# XDG Specification
export RTX_CACHE_DIR="${RTX_CACHE_DIR:-$XDG_CACHE_HOME}/rtx"
export RTX_USE_TOML=1

# Initialize rtx
if [ -z "$RTX_ACTIVATE_DISABLED" ]; then
  eval "$(rtx activate "$CURRENT_SHELL")"
fi

#
# Lazy loaded rtx
#

rtxd() {
  export RTX_ACTIVATE_DISABLED=1
  rtx deactivate
}

rtxa() {
  unset RTX_ACTIVATE_DISABLED
  rtx activate
}
