#!/usr/bin/env bash

set -eo pipefail

main() {
  local bin_dir="$DOTFILES_BIN"
  local mod_dir="$DOTFILES_MODULES_DIR"
  local modules=()

  # Install Homebrew
  "$mod_dir/homebrew/install.sh"

  # Load Homebrew shellenv
  source "$mod_dir/homebrew/.config/homebrew/shellenv.sh"

  # Install MacOS specific packages
  brew bundle

# Install dotfiles module scripts
  "$mod_dir/_core/install.sh"
  "$mod_dir/colima/install.sh"
  "$mod_dir/hammerspoon/install.sh"

  # Setup macos defaults
  "$mod_dir"/macos/__setup/defaults.sh

  # Ensure local modules directory exists
  mkdir -p "$DOTFILES_MODULES_DIR/local"

  # Default modules
  modules=(
    _stow
    _core
    1password
    bash
    bat
    colima
    direnv
    docker
    fzf
    git
    github
    gpg
    hammerspoon
    homebrew
    karabiner
    local
    macos
    mise
    neovim
    ripgrep
    ssh
    starship
    tmux
    utility
    vim
    wezterm
    zoxide
    zsh
  )

  # Create a modules file if it doesn't exist
  if [ ! -f "$DOTFILES_MODULES_FILE" ]; then
    cat <<EOF >"$DOTFILES_MODULES_FILE"
$(
      IFS=$'\n'
      echo "${modules[*]}"
    )
EOF
  fi

  # Link dotfiles
  "$bin_dir/dotfiles" mod link
}

main "$@"
