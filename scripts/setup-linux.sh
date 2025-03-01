#!/usr/bin/env bash

set -eo pipefail

export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

source "${DOTFILES_DIR}/modules/xdg/.config/profile.d/xdg.sh"

main() {
  local bin_dir="$DOTFILES_DIR/bin"
  local mod_dir="$DOTFILES_DIR/modules"
  local scripts_dir="$DOTFILES_DIR/scripts"
  local mod_file
  mod_file="$("$bin_dir"/dotfiles module file-path)"

  # Ensure local modules directory exists
  mkdir -p "$mod_dir/local"

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

  # No need to install packages
  export SKIP_PACKAGER_MANAGER_UPDATE="true"

  # Insall mise
  "$mod_dir/mise/install.sh"
  mise trust --yes
  # mise install rust --yes
  # mise install node --yes

  # Install dotfiles module scripts
  "$mod_dir/_base/install.sh"
  "$mod_dir/github/install.sh"
  "$mod_dir/nushell/install.sh"
  "$mod_dir/starship/install.sh"
  "$mod_dir/zsh/install.sh"

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

  # Write modules file
  if [ ! -f "$mod_file" ]; then
    # shellcheck disable=SC2068
    "$bin_dir"/dotfiles module write-file --file "$mod_file" ${default_modules[@]}
  fi

  # Link dotfiles
  "$bin_dir"/dotfiles module link

  # Set default shells
  "$scripts_dir"/set-default-shells.sh
}

main "$@"
