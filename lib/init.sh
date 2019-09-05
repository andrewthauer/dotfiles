#
# Initialize shared utils
#

# Core shared utils
source "${DOTFILES_DIR}/lib/utils.sh"

# Experimental
source "${DOTFILES_DIR}/lib/source_utils.sh"

# Set brew prefix
if command_exists "brew"; then
  [ -z ${BREW_PREFIX} ] && BREW_PREFIX="$(brew --prefix)"
fi
