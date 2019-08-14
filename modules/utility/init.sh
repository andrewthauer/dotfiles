#
# Initialize utility module
#

source "${DOTFILES_MODULES_DIR}/utility/aliases.sh"

# Initialize fasd if installed
if [[ -x "$(command -v fasd)" ]]; then
  eval "$(fasd --init auto)"
fi
