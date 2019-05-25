#
# Initialize docker module
#

if [[ -x "$(command -v docker)" ]]; then
  source "${DOTFILES_MOD_DIR}/docker/aliases.sh"
fi
