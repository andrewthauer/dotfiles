#
# Initialize git module
#

if [[ -x "$(command -v git)" ]]; then
  source "${DOTFILES_MODULES_DIR}/git/aliases.sh"
fi
