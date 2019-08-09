#
# Initialize redis module
#

if [[ -x "$(command -v redis-cli)" ]]; then
  # load aliases
  source "${DOTFILES_MODULES_DIR}/redis/aliases.sh"
fi
