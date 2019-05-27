#
# Load comon modules
# - work across sh/bash/zsh/etc
#

source "${DOTFILES_MODULES_DIR}/docker/init.sh"
source "${DOTFILES_MODULES_DIR}/git/init.sh"
source "${DOTFILES_MODULES_DIR}/dotfiles/init.sh"
source "${DOTFILES_MODULES_DIR}/dotnet/init.sh"
source "${DOTFILES_MODULES_DIR}/homebrew/init.sh"
source "${DOTFILES_MODULES_DIR}/node/init.sh"
source "${DOTFILES_MODULES_DIR}/python/init.sh"
source "${DOTFILES_MODULES_DIR}/ruby/init.sh"
source "${DOTFILES_MODULES_DIR}/rust/init.sh"
source "${DOTFILES_MODULES_DIR}/utility/init.sh"

# Initials fasd if exists
if [[ -x "$(command -v fasd)" ]]; then
  eval "$(fasd --init auto)"
fi
