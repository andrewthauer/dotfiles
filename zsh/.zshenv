#!/usr/bin/env zsh
#
# Defines environment variables
#

# Dotfiles directory
export ZDOTDIR="${ZDOTDIR:-$HOME}"
export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

# Zplug settings (and custom local)
export ZPLUG_HOME="${ZPLUG_HOME:-$HOME/.zplug}"
export ZPLUG_LOADFILE="${DOTFILES_DIR}/zsh/zplug.zsh"
export ZPLUG_LOCAL_LOADFILE="${HOME}/.zplug.local"

# Ensure path arrays do not contain duplicates
typeset -gU cdpath fpath mailpath path

# Set the list of directories that Zsh searches for programs
path=(
  /usr/local/{bin,sbin}
  $path
  $DOTFILES_DIR/bin
)

# Language
[[ -z "$LANG" ]] && export LANG='en_US.UTF-8'
export LC_CTYPE=${LANG}
export LC_ALL=${LANG}

# Editor
export EDITOR=vim
export VISUAL="${EDITOR}"

# zsh-nvm settings
export NVM_LAZY_LOAD=false
export NVM_AUTO_USE=true

# ls colors
export CLICOLOR=1

# Pager
export PAGER='less'
export LESS='-F -g -i -M -R -S -w -X -z-4'
export LESSCHARSET='utf-8'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

# Ensure that a non-login, non-interactive shell has a defined environment.
if [[ "$SHLVL" -eq 1 && ! -o LOGIN && -s "${HOME}/.zprofile" ]]; then
  source "${HOME}/.zprofile"
fi

# Load ~/.zshenv.local
if [[ -f "${HOME}/.zshenv.local" ]]; then
  source "${HOME}/.zshenv.local"
fi
