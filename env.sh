#
# Common environment settings
#

# Exported variables
export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

# Local variables (during sourcing)
DOTFILES_BIN_DIR="${DOTFILES_BIN_DIR:-$DOTFILES_DIR/bin}"
DOTFILES_MODULES_DIR="${DOTFILES_MODULES_DIR:-$DOTFILES_DIR/modules}"
DOTFILES_REPOS_DIR="${DOTFILES_REPOS_DIR:-$DOTFILES_DIR/repos}"
DOTFILES_LOCAL_DIR="${DOTFILES_LOCAL_DIR:-$DOTFILES_DIR/local}"
DOTFILES_ZFUNC_DIR="${DOTFILES_ZFUNC_DIR:-$DOTFILES_DIR/zfunc}"

# Append dotfiles/bin to path
export PATH="${PATH}:${DOTFILES_DIR}/bin"

# Language
export LANG="${LANG:-en_US.UTF-8}"
LC_CTYPE=${LANG}
LC_ALL=${LANG}

# Editor
export EDITOR=vim
export VISUAL="${EDITOR}"

# ls colors
export CLICOLOR=1

# Pager
export PAGER='less'
export LESS='-F -g -i -M -R -S -w -X -z-4'
export LESSCHARSET='utf-8'

# Set the Less input preprocessor
if type lesspipe.sh >/dev/null 2>&1; then
  export LESSOPEN='|lesspipe.sh %s'
fi

# Load local environment
if [[ -f "${DOTFILES_LOCAL_DIR}/env.sh" ]]; then
  source ${DOTFILES_LOCAL_DIR}/env.sh

  # Append dotfiles/local/bin to path
  export PATH="${PATH}:${DOTFILES_LOCAL_DIR}/bin"
fi
