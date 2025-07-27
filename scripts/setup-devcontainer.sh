#!/usr/bin/env bash

set -eo pipefail

DOTFILES_HOME="${DOTFILES_HOME:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." &>/dev/null && pwd)}"
source "${DOTFILES_HOME}/lib/xdg.sh"
PATH="${DOTFILES_HOME}/bin:${XDG_BIN_HOME}:${PATH}"

# Disable stow perl language warnings
export LANG="en_US.UTF-8"
export LC_ALL="C"

main() {
  local modules_dir="$DOTFILES_HOME/modules"
  local scripts_dir="$DOTFILES_HOME/scripts"

  #
  # Special handling for devcontainer setup
  #

  # Use custom dotfiles home
  echo "${DOTFILES_HOME}" >"${XDG_CONFIG_HOME}/dotfiles-home"

  # Use custom local module directory (avoid conflict with mounted volumes)
  local local_mod_name="local-devcontainer"
  local local_mod_dir="$modules_dir/$local_mod_name"

  # Set some common environment variables
  mkdir -p "$local_mod_dir/.config/environment.d"
  cat >"$local_mod_dir/.config/environment.d/devcontainer.conf" <<EOF
LANG="${LANG}"
EOF

  # Custom mise config to avoid conflicts with mounted volumes or base images
  mkdir -p "$local_mod_dir/.config/mise"
  mkdir -p "$(dirname "$local_mise_config_file")"
  local local_mise_config_file="${XDG_CONFIG_HOME}/mise/config.devcontainer.toml"
  touch "$local_mise_config_file"
  cat >"$local_mod_dir/.config/environment.d/mise.conf" <<EOF
MISE_GLOBAL_CONFIG_FILE="${local_mise_config_file}"
EOF
  # Move any existing mise config file to a backup
  if [ -f "$XDG_CONFIG_HOME/mise/config.toml" ] && [ ! -L "$XDG_CONFIG_HOME/mise/config.toml" ]; then
    mv "$XDG_CONFIG_HOME/mise/config.toml" "$XDG_CONFIG_HOME/config.toml.old"
  fi
  export MISE_GLOBAL_CONFIG_FILE="${local_mise_config_file}"

  #
  # Install, setup & configure
  #

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
    stow
    xdg
    base
    github
    # order doesn't matter
    bash
    carapace
    direnv
    fzf
    # git
    # jujutsu
    "$local_mod_name"
    mise
    # neovim
    nushell
    ripgrep
    starship
    xdg
    zoxide
    zsh
  )

  # Install dotfiles modules
  # shellcheck disable=SC2068
  dotfiles install --no-file ${default_modules[@]}

  # Set default shells
  DOTFILES_NO_SUDO=1 "$scripts_dir/set-default-shells.sh"
}

main "$@"
