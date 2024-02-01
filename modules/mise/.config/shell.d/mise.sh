#
# Configure mise-en-place environment
#
# - https://mise.jdx.dev/configuration.html
#
# NOTE: We need to ensure that mise is activated before any other dotfiles
#       modules are loaded, so that we can use mise to manage the environment.
#

#
# Initialization
#

# Activate mise
eval "$(mise activate "$CURRENT_SHELL")"

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
