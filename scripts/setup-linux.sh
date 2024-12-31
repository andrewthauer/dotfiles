#!/usr/bin/env bash

set -eo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

main() {
  local bin_dir="$DOTFILES_DIR/bin"
  local mod_dir="$DOTFILES_DIR/modules"
  local default_modules=()
  local mods_file
  mods_file="$("$bin_dir"/dotfiles mod modules-file)"

  # Install packages with package manager
  "$bin_dir/pkg" \
    stow \
    bash \
    direnv \
    fzf \
    git \
    neovim \
    zoxide \
    zsh

  # Ensure some directories exist
  mkdir -p "$HOME/.ssh"

  # Install dotfiles module scripts
  "$mod_dir/_base/install.sh"
  "$mod_dir/zsh/install.sh"
  "$mod_dir/starship/install.sh"

  # Default modules
  default_modules=(
    _base
    bash
    bat
    direnv
    docker
    fzf
    git
    github
    gpg
    local
    mise
    neovim
    ripgrep
    ssh
    starship
    zoxide
    xdg
    zsh
  )

  # Ensure local modules directory exists
  mkdir -p "$mod_dir/local"

  # Create a modules file if it doesn't exist
  if [ ! -f "$mods_file" ]; then
    cat <<EOF >"$mods_file"
$(
      IFS=$'\n'
      echo "${default_modules[*]}"
    )
EOF
  fi

  # Link dotfiles
  "$bin_dir/dotfiles" mod link
}

main "$@"
