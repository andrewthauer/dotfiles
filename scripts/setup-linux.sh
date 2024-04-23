#!/usr/bin/env bash

set -eo pipefail

main() {
  local bin="$DOTFILES_BIN"
  local mod="$DOTFILES_MODULES_DIR"
  local modules=()

  # Install packages with package manager
  "$bin/pkg" \
    stow \
    bash \
    direnv \
    fzf \
    git \
    neovim \
    zoxide \
    zsh

  # Install dotfiles module scripts
  "$mod_dir/_core/install.sh"
  "$mod_dir/zsh/install.sh"
  "$mod_dir/starship/install.sh"

  # Default modules
  modules=(
    _stow
    _core
    bash
    bat
    colima
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
