#
# Initialize redis module
#

if command_exists "redis-cli"; then
  # load aliases
  source "${DOTFILES_MODULES_DIR}/redis/aliases.sh"
fi
