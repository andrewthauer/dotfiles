#
# Initialize docker module
#

if [[ -x "$(command -v docker)" ]]; then
  source "${DOTFILES_MODULES_DIR}/docker/aliases.sh"
fi
