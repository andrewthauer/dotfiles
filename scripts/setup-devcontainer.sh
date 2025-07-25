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

  # Custom environment for devcontainer
  mkdir -p "$(dirname "$local_env_file")"
  mkdir -p "$(dirname "$local_mise_config_file")"
  touch "$local_mise_config_file"
  cat >"$local_env_file" <<EOF
# Custom environment variables for devcontainer
LANG="${LANG}"
MISE_GLOBAL_CONFIG_FILE="${local_mise_config_file}"
EOF

  # Create local module directory (not tracked by git)
  mkdir -p "$local_mod_dir"

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

  # Default modules
  local default_modules=(
    # needs to be installed first
    _base
    github
    # order doesn't matter
    bash
    carapace
    direnv
    fzf
    # git
    # gpg
    # jujutsu
    "$local_mod_name"
    mise
    # neovim
    nushell
    ripgrep
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
  DOTFILES_NO_SUDO=1 "$scripts_dir"/set-default-shells.sh
}

main "$@"
