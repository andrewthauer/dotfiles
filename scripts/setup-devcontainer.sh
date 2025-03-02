#!/usr/bin/env bash

set -eo pipefail

DOTFILES_HOME="${DOTFILES_HOME:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." &>/dev/null && pwd)}"
source "${DOTFILES_HOME}/lib/xdg.sh"
PATH="${DOTFILES_HOME}/bin:${XDG_BIN_HOME}:${PATH}"

# Disable stow perl language warnings
export LANG="en_US.UTF-8"

main() {
  local mod_dir="$DOTFILES_HOME/modules"
  local scripts_dir="$DOTFILES_HOME/scripts"
  local local_mod_name="local-devcontainer"
  local local_mod_dir="$mod_dir/$local_mod_name"
  local local_env_file="$local_mod_dir/.config/environment.d/devcontainer.conf"
  local local_mise_config_file="${XDG_CONFIG_HOME}/mise/config.devcontainer.toml"

  # Use custom dotfiles home
  echo "${DOTFILES_HOME}" >"${XDG_CONFIG_HOME}/dotfiles-home"

  # Base setup
  "$mod_dir/_base/install.sh"
  mkdir -p "$local_mod_dir"

  # Custom environment for devcontainer
  mkdir -p "$(dirname "$local_env_file")"
  mkdir -p "$(dirname "$local_mise_config_file")"
  touch "$local_mise_config_file"
  cat >"$local_env_file" <<EOF
# Custom environment variables for devcontainer
LANG="${LANG}"
MISE_GLOBAL_CONFIG_FILE="${local_mise_config_file}"
EOF

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
  mise trust --yes "$local_mise_config_file"

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
    direnv
    fzf
    # git
    github
    # gpg
    # jujutsu
    "$local_mod_name"
    mise
    ripgrep
    ssh
    starship
    # xdg
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
