#
# Initialize zoxide
#
# - https://github.com/ajeetdsouza/zoxide
#

# Ensure zoxide is installed
if ! command_exists "zoxide"; then
  return 1
fi

# Initialize xodize for bash
if [ -n "${BASH_VERSION}" ]; then
  eval "$(zoxide init bash)"

# Initialize xodize for zsh
elif [ -n "${ZSH_VERSION}" ]; then
  eval "$(zoxide init zsh)"

# Fallback to posix initialize
else
  eval "$(zoxide init posix --hook prompt)"
fi
