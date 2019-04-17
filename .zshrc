#!/usr/bin/env zsh
#
# Executes commands at the start of an interactive session
#

# Common shell initialization
source "${DOTFILES_DIR}/shell/aliases.sh"
source "${DOTFILES_DIR}/shell/init.sh"

# Base zsh config
source "${DOTFILES_DIR}/zsh/environment.zsh"
source "${DOTFILES_DIR}/zsh/completion.zsh"

# Load zplug & plugins
source "${DOTFILES_DIR}/zsh/zplug-load.zsh"

# Post zplug zsh config
source "${DOTFILES_DIR}/zsh/keybinds.zsh"
source "${DOTFILES_DIR}/zsh/history.zsh"

# Dotfiles module
source "${DOTFILES_DIR}/modules/dotfiles/init.zsh"

# Load the local zsh file
if [[ -f "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi
