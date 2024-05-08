#!/usr/bin/env bash

set -eo pipefail

main() {
  local bin_dir="$DOTFILES_BIN"
  local mod_dir="$DOTFILES_MODULES_DIR"
  local default_modules=()

  # Core setup
  # "$mod_dir/_core/install.sh"

  # Install Homebrew
  "$mod_dir/homebrew/install.sh"

  # Load Homebrew shellenv
  source "$mod_dir/homebrew/.config/homebrew/shellenv.sh"

  # Install MacOS specific packages
  export HOMEBREW_BUNDLE_FILE="${mod_dir}/macos/.config/homebrew/Brewfile"
  brew bundle --no-lock

  # Default modules
  default_modules=(
    _base
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

  # Ensure local modules directory exists
  mkdir -p "$DOTFILES_MODULES_DIR/local"

  # Create a modules file if it doesn't exist
  if [ ! -f "$DOTFILES_MODULES_FILE" ]; then
    cat <<EOF >"$DOTFILES_MODULES_FILE"
$(
      IFS=$'\n'
      echo "${default_modules[*]}"
    )
EOF
  fi

  # Link dotfiles
  "$bin_dir/dotfiles" mod link

  # Install dotfiles module scripts
  "$mod_dir/docker/install.sh"
  "$mod_dir/hammerspoon/install.sh"

  # Setup macos defaults
  "$DOTFILES_DIR/scripts/macos-defaults.sh"
}

main "$@"
