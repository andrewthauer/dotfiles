#
# Configure mise-en-place environment
#
# - https://mise.jdx.dev/getting-started.html
#

# Use mise toml instead of .tool-versions
export MISE_USE_TOML=1

#
# Initialization
#

# NOTE: We add the shims directory to the PATH before activating mise, so that
#       modules which are loaded work.
eval "$(mise activate "$CURRENT_SHELL" --shims)"
