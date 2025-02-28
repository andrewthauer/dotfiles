#!/usr/bin/env bash

set -eo pipefail

DOTFILES_DIR="${DOTFILES:-$HOME/.dotfiles}"

main() {
  local bin_dir="$DOTFILES_DIR/bin"
  local mod_dir="$DOTFILES_DIR/modules"

  # Core setup
  "$mod_dir/_base/install.sh"

  # Install & load Homebrew shellenv
  "$mod_dir/homebrew/install.sh"
  # shellcheck source=/dev/null
  source "$mod_dir/homebrew/.config/homebrew/shellenv.sh"

  # Install MacOS specific packages
  export HOMEBREW_BUNDLE_FILE="${mod_dir}/homebrew/.config/homebrew/Brewfile"
  brew bundle --no-lock

  # Install dotfiles module scripts
  "$mod_dir/docker/install.sh"
  "$mod_dir/github/install.sh"
  "$mod_dir/hammerspoon/install.sh"
  "$mod_dir/neovim/install.sh"

  # Default modules
  local default_modules=(
    _base
    bash
    bat
    deno
    direnv
    docker
    fzf
    git
    github
    go
    gpg
    ghostty
    hammerspoon
    homebrew
    jujutsu
    karabiner
    local
    macos
    mise
    neovim
    nodejs
    op
    python
    ripgrep
    ruby
    rust
    ssh
    starship
    xdg
    zed
    zoxide
    zsh
  )

  # Ensure local modules directory exists
  mkdir -p "$mod_dir/local"

  # Link dotfiles
  # shellcheck disable=SC2068
  "$bin_dir/dotfiles" mod link ${default_modules[@]}

  # install mise versions
  # mise trust --yes
  # mise install node --yes

  # Setup macos defaults
  "$DOTFILES_DIR/scripts/macos-defaults.sh"

  # Set default shells
  "$DOTFILES_DIR/scripts/set-default-shells.sh"
}

main "$@"
