#!/usr/bin/env zsh
#
# Executes commands at the start of an interactive session
#

# Common shell config
source "${DOTFILES_DIR}/shell/init.sh"

# Zsh config (order matters)
source "${DOTFILES_DIR}/zsh/environment.zsh"
source "${DOTFILES_DIR}/zsh/keybinds.zsh"
source "${DOTFILES_DIR}/zsh/history.zsh"
source "${DOTFILES_DIR}/zsh/completion.zsh"

# Load plugins
source "${DOTFILES_DIR}/zsh/plugins.zsh"
# source "${DOTFILES_DIR}/zsh/zplug-load.zsh"

# Load modules
source "${DOTFILES_DIR}/brew/aliases.sh"
source "${DOTFILES_DIR}/docker/aliases.sh"
source "${DOTFILES_DIR}/git/aliases.sh"
# source "${DOTFILES_DIR}/dotnet/init.sh"
source "${DOTFILES_DIR}/modules/dotfiles/init.zsh"
source "${DOTFILES_DIR}/node/init.sh"
source "${DOTFILES_DIR}/python/init.sh"
source "${DOTFILES_DIR}/ruby/init.sh"
source "${DOTFILES_DIR}/rust/init.sh"
source "${DOTFILES_DIR}/shell/aliases.sh"
source "${DOTFILES_DIR}/zsh/aliases.zsh"

# Load prompt theme
source "${DOTFILES_DIR}/zsh/prompt.zsh"

# Load the local zsh file
if [[ -f "$HOME/.zshrc.local" ]]; then
  source "$HOME/.zshrc.local"
fi
