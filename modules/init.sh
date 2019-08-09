#
# Load comon modules
# - work across sh/bash/zsh/etc
#

MODULES_DIR="${DOTFILES_MODULES_DIR}"

# general utils
source "${MODULES_DIR}/dotfiles/init.sh"
source "${MODULES_DIR}/homebrew/init.sh"
source "${MODULES_DIR}/utility/init.sh"

# tool helpers
source "${MODULES_DIR}/docker/init.sh"
source "${MODULES_DIR}/git/init.sh"
source "${MODULES_DIR}/kubernetes/init.sh"
source "${MODULES_DIR}/redis/init.sh"

# language support (more expensive)
source "${MODULES_DIR}/dotnet/init.sh"
source "${MODULES_DIR}/java/init.sh"
source "${MODULES_DIR}/node/init.sh"
source "${MODULES_DIR}/python/init.sh"
source "${MODULES_DIR}/ruby/init.sh"
source "${MODULES_DIR}/rust/init.sh"

# Initialize fasd if installed
if [[ -x "$(command -v fasd)" ]]; then
  eval "$(fasd --init auto)"
fi
