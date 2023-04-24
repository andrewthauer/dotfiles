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

# Use rtx toml instead of .tool-versions
export RTX_USE_TOML=1

# Use shims directory
prepend_path "${XDG_DATA_HOME}/rtx/shims"

#
# Initialization
#

# Avoid issues with nix shells from devenv
if command_exists "devenv"; then
  if [ -n "$DEVENV_DIR" ]; then
    export RTX_AUTO_ACTIVATE_DISABLED=1
  fi
fi

# Initialize rtx
if [ -z "$RTX_AUTO_ACTIVATE_DISABLED" ]; then
  eval "$(rtx activate "$CURRENT_SHELL")"
fi

#
# Lazy loaded rtx
#

rtxa() {
  unset RTX_AUTO_ACTIVATE_DISABLED
  rtx activate
}

rtxd() {
  export RTX_AUTO_ACTIVATE_DISABLED=1
  rtx deactivate
}
