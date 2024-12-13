#
# Initialize zoxide
#
# - https://github.com/ajeetdsouza/zoxide
#

# shellcheck disable=SC1090

# Ensure zoxide is installed
if ! command_exists "zoxide"; then
  return 1
fi

# Set the data directory for zoxide
# NOTE: on macOS defaults to "$HOME/Library/Application Support"
export _ZO_DATA_DIR="${XDG_DATA_HOME:-$HOME/.local/share}/zoxide"

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
