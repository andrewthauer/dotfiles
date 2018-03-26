#!/usr/bin/env zsh
#
# Executes commands at the start of an interactive session
#

# Base zsh config
source "${DOTFILES_DIR}/config/zsh/environment.zsh"
source "${DOTFILES_DIR}/config/zsh/completion.zsh"

# Load zplug & plugins
source "${DOTFILES_DIR}/config/zsh/zplug-load.zsh"

# Post zplug zsh config
source "${DOTFILES_DIR}/config/zsh/keybinds.zsh"
source "${DOTFILES_DIR}/config/zsh/history.zsh"

# Common aliases
source "${DOTFILES_DIR}/config/shared/aliases.sh"

# Load the local zsh file
if [[ -f "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi
