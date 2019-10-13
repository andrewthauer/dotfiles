#
# Initialize shared utils
#

# Core shared utils
source "${DOTFILES_DIR}/lib/utils.sh"
source "${DOTFILES_DIR}/lib/lazyfunc.sh"
source "${DOTFILES_DIR}/lib/source-utils.sh"
source "${DOTFILES_DIR}/lib/stow.sh"

# Set brew prefix if macos to avoid using "$(brew --prefix)"
if [[ "$OSTYPE" == darwin* ]]; then
  BREW_PREFIX="${BREW_PREFIX:-/usr/local}"
fi
