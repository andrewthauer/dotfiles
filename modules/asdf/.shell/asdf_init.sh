#
# Initialze asdf environment
#
# - https://github.com/asdf-vm/asdf
#

if [[ ! -d "${HOME}/.asdf" ]]; then
  return
fi

# The home directory
export ASDF_DIR="${ASDF_DIR:-$HOME/.asdf}"

# Initialize asdf
source "${ASDF_DIR}/asdf.sh"

# Setup completions
if [[ -n "${ZSH_NAME}" ]]; then
  source "${ASDF_DIR}/completions/asdf.zsh"
elif [[ -n "${BASH_VERSION}" ]]; then
  source "${ASDF_DIR}/completions/asdf.bash"
fi

#
# Aliases & helpers
#

alias asdfc="asdf current"
