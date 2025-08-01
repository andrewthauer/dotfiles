#!/usr/bin/env bash

set -eo pipefail

DOTFILES_HOME="${DOTFILES_HOME:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." &>/dev/null && pwd)}"
source "${DOTFILES_HOME}/lib/xdg.sh"
PATH="${DOTFILES_HOME}/bin:${XDG_BIN_HOME}:${PATH}"

main() {
  local modules_dir="$DOTFILES_HOME/modules"
  local scripts_dir="$DOTFILES_HOME/scripts"
  local modules_file
  modules_file="$(dotfiles module file-path)"

  # Create local module directory (not tracked by git)
  mkdir -p "$modules_dir/local"

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

  # Base setup
  mkdir -p "$modules_dir/local"

  # No need to update the package managers anymore
  export SKIP_PACKAGER_MANAGER_UPDATE="true"

  # Default modules
  local default_modules=(
    # needs to be installed first
    stow
    xdg
    base
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
    linux
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
  dotfiles install --file "$modules_file" ${default_modules[@]}

  # Set default shells
  "$scripts_dir/set-default-shells.sh"
}

main "$@"
