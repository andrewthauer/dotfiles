#!/usr/bin/env zsh
#
# Executes commands at the start of an interactive session
#

# Common shell config
source "${DOTFILES_DIR}/shell/init.sh"

# Zsh config (order matters)
source "${DOTFILES_DIR}/zsh/environment.zsh"
source "${DOTFILES_DIR}/zsh/zplug-load.zsh"
source "${DOTFILES_DIR}/zsh/keybinds.zsh"
source "${DOTFILES_DIR}/zsh/history.zsh"

# Initialize tools
source "${DOTFILES_DIR}/node/init.sh"
source "${DOTFILES_DIR}/python/init.sh"
source "${DOTFILES_DIR}/ruby/init.sh"
source "${DOTFILES_DIR}/rust/init.sh"

# Aliases
source "${DOTFILES_DIR}/shell/aliases.sh"
source "${DOTFILES_DIR}/git/aliases.sh"
source "${DOTFILES_DIR}/brew/aliases.sh"
source "${DOTFILES_DIR}/docker/aliases.sh"
source "${DOTFILES_DIR}/node/aliases.sh"
source "${DOTFILES_DIR}/ruby/aliases.sh"

# Modules
source "${DOTFILES_DIR}/modules/dotfiles/init.zsh"

# Load completion (compinit must be after fpath is finalized)
source "${DOTFILES_DIR}/zsh/completion.zsh"

# Load the local zsh file
if [[ -f "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi
