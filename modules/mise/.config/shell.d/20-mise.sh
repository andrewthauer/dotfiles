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
mise-activate-shims

# Activate mise
if [ "$MISE_AUTO_ACTIVATE" != "0" ]; then
  mise-activate
fi

#
# Aliases
#

alias m="mise"
alias md="mise deactivate"
alias mi="mise install"
alias mr="mise run"
alias mu="mise use"
alias mx="mise exec"
alias mlsr="mise ls-remote"
alias mplsr="mise plugin ls-remote --urls"
alias mt="mise task"
alias mtr="mise task run"

# short aliases
alias mhook="mise-hook-env"
alias mact="mise-activate"

# Alias rtx to mise for backwards compatibility
alias rtx="mise"
