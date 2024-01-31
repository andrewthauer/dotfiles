#
# Configure mise environment
#
# - https://mise.jdx.dev/configuration.html
#

# Use mise toml instead of .tool-versions
export MISE_USE_TOML=1

#
# Initialization
#

# Initialize mise shims
eval "$(mise activate --shims)"

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
