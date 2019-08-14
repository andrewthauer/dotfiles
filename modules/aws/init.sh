#
# Initialize aws module
#

if [[ -x "$(command -v aws)" ]]; then
  # load aliases
  source "${DOTFILES_MODULES_DIR}/aws/aliases.sh"
fi
