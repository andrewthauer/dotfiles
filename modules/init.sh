#
# Load comon modules
# - work across sh/bash/zsh/etc
#

MODULES_DIR="${DOTFILES_MODULES_DIR}"

# shared utils (must be loaded first)
source "${MODULES_DIR}/shared/utils.sh"

# general utils
source "${MODULES_DIR}/dotfiles/init.sh"
source "${MODULES_DIR}/fasd/init.sh"
source "${MODULES_DIR}/homebrew/init.sh"
source "${MODULES_DIR}/utility/init.sh"

# tool helpers
source "${MODULES_DIR}/docker/init.sh"
source "${MODULES_DIR}/git/init.sh"
source "${MODULES_DIR}/kubernetes/init.sh"
source "${MODULES_DIR}/redis/init.sh"

# language support
source "${MODULES_DIR}/dotnet/init.sh"
source "${MODULES_DIR}/go/init.sh"
source "${MODULES_DIR}/java/init.sh"
source "${MODULES_DIR}/node/init.sh"
source "${MODULES_DIR}/python/init.sh"
source "${MODULES_DIR}/ruby/init.sh"
source "${MODULES_DIR}/rust/init.sh"
source "${MODULES_DIR}/scala/init.sh"

# platform tools
source "${MODULES_DIR}/aws/init.sh"
source "${MODULES_DIR}/gcloud/init.sh"
