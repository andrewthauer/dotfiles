# Initialize mise
if ! command_exists "mise"; then
  return 1
elif [ -n "${BASH_VERSION}" ]; then
  eval "$(mise activate bash)"
elif [ -n "${ZSH_VERSION}" ]; then
  eval "$(mise activate zsh)"
else
  return 1
fi

# Aliases
alias m="mise"
alias mr="mise run"
