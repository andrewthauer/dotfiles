#
# Initialize aws module
#

# load aliases
if command_exists "aws"; then
  source "${DOTFILES_MODULES_DIR}/aws/aliases.sh"
fi
