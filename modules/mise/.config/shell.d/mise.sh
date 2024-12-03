#
# Configure mise-en-place environment
#
# - https://mise.jdx.dev/configuration.html
#
# NOTE: We need to ensure that mise is activated before any other dotfiles
#       modules are loaded, so that we can use mise to manage the environment.
#

#
# Environment
#

# Custom details
# MISE_AUTO_ACTIVATE_SHIMS=1
# MISE_AUTO_ACTIVATE=0

# Force mise to use aggressive activation
export MISE_ACTIVATE_AGGRESSIVE=1

# Use mise toml instead of .tool-versions
export MISE_USE_TOML=1

#
# Functions
#

mise-activate() {
  eval "$(mise activate "$SHELL_TYPE")"
}

mise-activate-shims() {
  eval "$(mise activate "$SHELL_TYPE" --shims)"
}

mise-hook-env() {
  eval "$(/opt/homebrew/bin/mise hook-env -s zsh)"
}

#
# Activation
#

# NOTE: We add the shims directory to the PATH before activating mise, so that
#       modules which are loaded work.
if [ "$MISE_AUTO_ACTIVATE_SHIMS" != "0" ]; then
  mise-activate-shims
fi

# Activate mise
if [ "$MISE_AUTO_ACTIVATE" != "0" ]; then
  mise-activate
fi

#
# Aliases
#

alias m="mise"

# short aliases
alias mhook="mise-hook-env"
alias mact="mise-activate"
