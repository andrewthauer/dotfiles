#!/usr/bin/env bash

set -eo pipefail

DOTFILES_DIR="${DOTFILES:-$HOME/.dotfiles}"
DOTFILES_MODULES_FILE="${DOTFILES_MODULES_FILE:-$DOTFILES_DIR/.modules}"

main() {
  local bin_dir="$DOTFILES_DIR/bin"
  local mod_dir="$DOTFILES_DIR/modules"
  local default_modules=()

  # Core setup
  # "$mod_dir/_base/install.sh"

  # Install Homebrew
  "$mod_dir/homebrew/install.sh"

  # Load Homebrew shellenv
  # shellcheck source=/dev/null
  source "$mod_dir/homebrew/.config/homebrew/shellenv.sh"

  # Install MacOS specific packages
  export HOMEBREW_BUNDLE_FILE="${mod_dir}/homebrew/.config/homebrew/Brewfile"
  brew bundle --no-lock

  # Ensure some directories exist
  mkdir -p "$HOME/.ssh"

  # Default modules
  default_modules=(
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

  # Setup SSH for GitHub
  if [ -f "$HOME/.ssh/known_hosts" ]; then
    ssh-keygen -R github.com
    ssh-keyscan -t rsa github.com >>~/.ssh/known_hosts
  else
    ssh-keyscan -t rsa github.com >~/.ssh/known_hosts
  fi

  # Install dotfiles module scripts
  "$mod_dir/docker/install.sh"
  "$mod_dir/hammerspoon/install.sh"

  # install mise versions
  mise install node

  # Setup macos defaults
  "$DOTFILES_DIR/scripts/macos-defaults.sh"
}

main "$@"
