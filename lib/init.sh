#
# Initialize shared utils
#

# Core shared utils
source "${DOTFILES_DIR}/lib/utils.sh"

#
# Require a module once for the shell session
#
# examples:
#   require_once "utils"
#
require_once() {
  module=$1
  file="${XDG_CONFIG_HOME}/profile.d/${1}.sh"
  source_file "$file"
}
