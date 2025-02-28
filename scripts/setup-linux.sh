#!/usr/bin/env bash

set -eo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

main() {
  local bin_dir="$DOTFILES_DIR/bin"
  local mod_dir="$DOTFILES_DIR/modules"

  # Disable stow perl language warnings
  export LANG="en_US.UTF-8"

  # Install packages with package manager
  "$bin_dir/pkg" install \
    stow \
    bash \
    direnv \
    fzf \
    git \
    shellcheck \
    shfmt \
    zoxide \
    zsh

  # Install dotfiles module scripts
  export SKIP_PACKAGER_MANAGER_UPDATE="true"
  "$mod_dir/_base/install.sh"
  "$mod_dir/github/install.sh"
  "$mod_dir/mise/install.sh"
  "$mod_dir/nushell/install.sh"
  "$mod_dir/starship/install.sh"
  "$mod_dir/zsh/install.sh"

  # TODO: Install
  # jj
  # neovim

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
    jujutsu
    local
    mise
    neovim
    nodejs
    ripgrep
    ruby
    rust
    ssh
    starship
    xdg
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

  # Set default shells
  "$DOTFILES_DIR/scripts/set-default-shells.sh"
}

main "$@"
