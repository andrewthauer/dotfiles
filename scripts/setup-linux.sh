#!/usr/bin/env bash

set -eo pipefail

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"

main() {
  local bin_dir="$DOTFILES_BIN"
  local mod_dir="$DOTFILES_MODULES_DIR"
  local modules=()

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
  modules=(
    _base
    bash
    bat
    direnv
    docker
    fzf
    git
    github
    gpg
    mise
    neovim
    ripgrep
    ssh
    starship
    tmux
    wezterm
    zoxide
    xdg
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
