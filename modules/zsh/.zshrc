#!/usr/bin/env zsh
#
# Executes commands at the start of an interactive session
#

# Zsh config (order matters)
source "${DOTFILES_MOD_DIR}/zsh/environment.zsh"
source "${DOTFILES_MOD_DIR}/zsh/keybinds.zsh"
source "${DOTFILES_MOD_DIR}/zsh/history.zsh"
source "${DOTFILES_MOD_DIR}/zsh/completion.zsh"
source "${DOTFILES_MOD_DIR}/zsh/plugins.zsh"
source "${DOTFILES_MOD_DIR}/zsh/aliases.zsh"

# Common config & modules
source "${DOTFILES_MOD_DIR}/init.sh"

# Load prompt theme
source "${DOTFILES_MOD_DIR}/zsh/prompt.zsh"

# Load the local zsh file
if [[ -f "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi
