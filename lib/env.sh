#
# Dotfiles environment variables
#

export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

# export DOTFILES_PACKAGE_MANAGER=""

prepend_path "${DOTFILES_DIR}/bin"
