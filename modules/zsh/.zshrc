#!/usr/bin/env zsh
#
# Executes commands at the start of an interactive session
#

# Enable zprof performance profiling
[[ -n $ZPROF ]] && zmodload zsh/zprof

# Zsh config (order matters)
source "${DOTFILES_MODULES_DIR}/zsh/environment.zsh"
source "${DOTFILES_MODULES_DIR}/zsh/keybinds.zsh"
source "${DOTFILES_MODULES_DIR}/zsh/history.zsh"
source "${DOTFILES_MODULES_DIR}/zsh/completion.zsh"
source "${DOTFILES_MODULES_DIR}/zsh/plugins.zsh"

# Common config & modules
source "${DOTFILES_MODULES_DIR}/init.sh"

# Load prompt theme
source "${DOTFILES_MODULES_DIR}/zsh/prompt.zsh"

# Load the local zsh file
if [[ -f "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi
