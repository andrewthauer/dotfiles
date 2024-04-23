#
# Dotfiles environment variables
#

export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

export DOTFILES_BIN="$DOTFILES_DIR/bin"
export DOTFILES_MODULES_DIR="${DOTFILES_DIR}/modules"
export DOTFILES_MODULES_FILE="${DOTFILES_MODULES_FILE:-$DOTFILES_DIR/.modules}"

# export DOTFILES_ENV_FILE=""
# export DOTFILES_PACKAGE_MANAGER=""

prepend_path="${DOTFILES_DIR}/bin"
