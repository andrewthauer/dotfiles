#
# Initialze asdf environment
#
# - https://github.com/asdf-vm/asdf
#

if ! command_exists "mise"; then
  return 1
fi

# XDG Specification
export MISE_CACHE_DIR="${MISE_CACHE_DIR:-$XDG_CACHE_HOME}/mise"

# Use mise toml instead of .tool-versions
export MISE_USE_TOML=1

# Use shims directory
prepend_path "${XDG_DATA_HOME}/mise/shims"

#
# Initialization
#

# Avoid issues with nix shells from devenv
if command_exists "devenv"; then
  if [ -n "$DEVENV_DIR" ]; then
    export MISE_AUTO_ACTIVATE_DISABLED=1
  fi
fi

# Initialize mise
if [ -z "$MISE_AUTO_ACTIVATE_DISABLED" ]; then
  eval "$(mise activate "$CURRENT_SHELL")"
fi

#
# Lazy loaded mise
#

misea() {
  unset MISE_AUTO_ACTIVATE_DISABLED
  mise activate
}

mised() {
  export MISE_AUTO_ACTIVATE_DISABLED=1
  mise deactivate
}
