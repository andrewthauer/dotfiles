#!/usr/bin/env bash

set -eo pipefail

export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

main() {
  local bin_dir="$DOTFILES_DIR/bin"
  local mod_dir="$DOTFILES_DIR/modules"
  local scripts_dir="$DOTFILES_DIR/scripts"
  local mods_file
  mods_file="$("$bin_dir"/dotfiles module file-path)"

  # Ensure local modules directory exists
  mkdir -p "$mod_dir/local"

  # Core setup
  "$mod_dir/_base/install.sh"

  # Install & load Homebrew shellenv
  "$mod_dir/homebrew/install.sh"

  # shellcheck source=/dev/null
  source "$mod_dir/homebrew/.config/homebrew/shellenv.sh"

  # Install MacOS specific packages
  export HOMEBREW_BUNDLE_FILE="${mod_dir}/homebrew/.config/homebrew/Brewfile"
  brew bundle --no-lock

  # Setup mise
  mise trust --yes
  # mise install rust --yes
  # mise install node --yes

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

  # Write modules file
  if [ ! -f "$mods_file" ]; then
    # shellcheck disable=SC2068
    "$bin_dir"/dotfiles module write-file --file "$mods_file" ${default_modules[@]}
  fi

  # Link dotfiles
  "$bin_dir"/dotfiles module link

  # Setup macos defaults
  "$scripts_dir/scripts/macos-defaults.sh"

  # Set default shells
  "$scripts_dir"/set-default-shells.sh
}

main "$@"
