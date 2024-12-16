#
# Configure mise-en-place environment
#
# - https://mise.jdx.dev/configuration.html
#

# Initialize mise for bash
if [ -n "${BASH_VERSION}" ]; then
  eval "$(mise activate bash)"

# Initialize mise for zsh
elif [ -n "${ZSH_VERSION}" ]; then
  eval "$(mise activate zsh)"

# No shell support
else
  return 1
fi

# Aliases
alias m="mise"
alias mr="mise run"
