#
# Initialize docker module
#

if command_exists "docker"; then
  # load aliases
  source "${DOTFILES_MODULES_DIR}/docker/aliases.sh"
fi
