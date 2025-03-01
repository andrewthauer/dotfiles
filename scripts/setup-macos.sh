#!/usr/bin/env bash

set -eo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." &>/dev/null && pwd)}"
PATH="$DOTFILES_DIR/bin:$PATH"

source "${DOTFILES_DIR}/modules/xdg/.config/profile.d/xdg.sh"

main() {
  local scripts_dir="$DOTFILES_DIR/scripts"
  local mod_file
  mod_file="$(dotfiles module file-path)"

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
  if [ ! -f "$mod_file" ]; then
    # shellcheck disable=SC2068
    dotfiles module write-file --file "$mod_file" ${default_modules[@]}
  fi

  # Link dotfiles
  dotfiles module link --file "$mod_file"

  # Setup macos defaults
  "$scripts_dir/scripts/macos-defaults.sh"

  # Set default shells
  "$scripts_dir"/set-default-shells.sh
}

main "$@"
