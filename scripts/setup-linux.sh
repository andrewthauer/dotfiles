#!/usr/bin/env bash

set -eo pipefail

DOTFILES_HOME="${DOTFILES_HOME:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." &>/dev/null && pwd)}"
source "${DOTFILES_HOME}/lib/xdg.sh"
PATH="${DOTFILES_HOME}/bin:${XDG_BIN_HOME}:${PATH}"

main() {
  local mod_dir="$DOTFILES_HOME/modules"
  local scripts_dir="$DOTFILES_HOME/scripts"

  # Create local module directory (not tracked by git)
  mkdir -p "$mod_dir/local"

  # Install packages with package manager
  pkg install \
    bash \
    direnv \
    fonts-firacode \
    fzf \
    git \
    shellcheck \
    shfmt \
    stow \
    zoxide \
    zsh

  # No need to install packages
  export SKIP_PACKAGER_MANAGER_UPDATE="true"

  # Base setup
  mkdir -p "$mod_dir/local"

  # Default modules
  local default_modules=(
    # needs to be installed first
    _base
    github
    # order doesn't matter
    bash
    bat
    carapace
    deno
    direnv
    docker
    fzf
    git
    go
    gpg
    jujutsu
    local
    mise
    neovim
    nodejs
    nushell
    ripgrep
    ruby
    rust
    ssh
    starship
    xdg
    zoxide
    zsh
  )

  # Install dotfiles modules
  # shellcheck disable=SC2068
  dotfiles module install --no-file ${default_modules[@]}

  # Set default shells
  "$scripts_dir"/set-default-shells.sh
}

main "$@"
