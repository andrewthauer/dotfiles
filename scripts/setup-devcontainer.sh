#!/usr/bin/env bash

set -eo pipefail

DOTFILES_HOME="${DOTFILES_HOME:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." &>/dev/null && pwd)}"
PATH="$DOTFILES_HOME/bin:$PATH"

source "${DOTFILES_HOME}/modules/xdg/.config/profile.d/xdg.sh"

# Disable stow perl language warnings
export LANG="en_US.UTF-8"

main() {
  local mod_dir="$DOTFILES_HOME/modules"
  local scripts_dir="$DOTFILES_HOME/scripts"

  # Use custom dotfiles home
  echo "${DOTFILES_HOME}" >"${XDG_CONFIG_HOME}/dotfiles-home"

  # Base setup
  "$mod_dir/_base/install.sh"
  mkdir -p "$mod_dir/local"

  # Install packages with package manager
  pkg install \
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
  "$mod_dir/github/install.sh"
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
    # git
    github
    go
    # gpg
    # jujutsu
    # local
    mise
    # neovim
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

  # Link dotfiles
  # shellcheck disable=SC2068
  dotfiles module link --no-file ${default_modules[@]}

  # Set default shells
  DOTFILES_NO_SUDO=1 "$scripts_dir"/set-default-shells.sh
}

main "$@"
