#
# asdf - extendable version manager
# - https://github.com/asdf-vm/asdf
#

# The home directory
export ASDF_DIR="${ASDF_DIR:-$HOME/.asdf}"

# Skip if asdf is not installed
if [[ ! -d "${ASDF_DIR}" ]]; then
  unset ASDF_DIR
  return
fi

# Initialize asdf
source "${ASDF_DIR}/asdf.sh"
source "${ASDF_DIR}/completions/asdf.bash"

# Add custom commands the path
path+="${0:h}/bin"

#
# Aliases & helpers
#

alias asdfc="asdf current"
