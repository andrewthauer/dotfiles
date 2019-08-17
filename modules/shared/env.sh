#
# Common environment settings
#

# Exported variables
export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

# Local variables (during sourcing)
DOTFILES_BIN_DIR="${DOTFILES_BIN_DIR:-$DOTFILES_DIR/bin}"
DOTFILES_MODULES_DIR="${DOTFILES_MODULES_DIR:-$DOTFILES_DIR/modules}"
DOTFILES_REPOS_DIR="${DOTFILES_REPOS_DIR:-$DOTFILES_DIR/repos}"
DOTFILES_LOCAL_DIR="${DOTFILES_LOCAL_DIR:-$DOTFILES_DIR/local}"
DOTFILES_ZFUNC_DIR="${DOTFILES_ZFUNC_DIR:-$DOTFILES_DIR/zfunc}"

# Append dotfiles/bin to path
export PATH="${PATH}:${DOTFILES_DIR}/bin"
