#!/usr/bin/env zsh
#
# Defines zsh environment & changes to use XGD directories
#

# The current shell type
export CURRENT_SHELL="zsh"

# Dotfiles dir
export DOTFILES_DIR="${DOTFILES_DIR:-${HOME}/.dotfiles}"

# Load common shell env
source "${XDG_CONFIG_HOME}/profile"

# Ensure path arrays do not contain duplicates
typeset -gU cdpath fpath mailpath path


# Set the list of directories that Zsh searches for programs
path=(
  ~/.local/bin
  ${DOTFILES_DIR}/bin
  $path
)

# Set the function path
fpath=(
  $XDG_DATA_HOME/zsh/functions
  $fpath
)

# Prompt
ZSH_PROMPT="pure"
if [[ -d "${XDG_DATA_HOME}/${ZSH_PROMPT}" ]]; then
  fpath+="${XDG_DATA_HOME}/${ZSH_PROMPT}"
fi

# Load local zshenv (if exists)
if [[ -f "${XDG_CONFIG_HOME}/zsh/.zshenv.local" ]]; then
  source "${XDG_CONFIG_HOME}/zsh/.zshenv.local"
fi

# Ensure that a non-login, non-interactive shell has a defined environment
# if [[ ("$SHLVL" -eq 1 && ! -o LOGIN) && -s "${ZDOTDIR}/.zprofile" ]]; then
#   source "${ZDOTDIR}/.zprofile"
# fi
