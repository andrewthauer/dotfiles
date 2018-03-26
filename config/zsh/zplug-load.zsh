#
# Zplug initialization
#

# Zplug settings
ZPLUG_HOME="${ZPLUG_HOME:-$HOME/.zplug}"
ZPLUG_LOADFILE="${ZPLUG_LOADFILE:-$DOTFILES_DIR/config/zsh/zplug-packages.zsh}"
# ZPLUG_LOADFILE_LOCAL=

# Initialize zplug
if [[ -f "${ZPLUG_HOME}/init.zsh" ]]; then
  source "${ZPLUG_HOME}/init.zsh"
  zplug load ${ZPLUG_LOAD_OPTIONS}
fi
