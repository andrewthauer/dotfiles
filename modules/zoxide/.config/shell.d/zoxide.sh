# Initialize zoxide
if ! command_exists "zoxide"; then
  return 1
elif [ -n "${BASH_VERSION}" ]; then
  eval "$(zoxide init bash)"
elif [ -n "${ZSH_VERSION}" ]; then
  eval "$(zoxide init zsh)"
else
  eval "$(zoxide init posix --hook prompt)"
fi
