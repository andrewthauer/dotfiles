#!/usr/bin/env bash

set -eo pipefail

DOTFILES_HOME="${DOTFILES_HOME:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." &>/dev/null && pwd)}"
source "${DOTFILES_HOME}/lib/xdg.sh"
PATH="${DOTFILES_HOME}/bin:${XDG_BIN_HOME}:${PATH}"

# Indicate that this is a devcontainer setup
export REMOTE_CONTAINERS=true
export DEVPOD=true

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
  export DOTFILES_LOCAL_MODULE_PATH="${modules_dir}/${local_mod_name}"

  # Set some common environment variables
  mkdir -p "${DOTFILES_LOCAL_MODULE_PATH}/.config/environment.d"
  cat >"$DOTFILES_LOCAL_MODULE_PATH/.config/environment.d/devcontainer.conf" <<EOF
LANG="${LANG}"
EOF

  # Custom mise config to avoid conflicts with mounted volumes or base images
  export MISE_GLOBAL_CONFIG_FILE="${DOTFILES_LOCAL_MODULE_PATH}/.config/mise/config.devcontainer.toml"

  #
  # Install, setup & configure
  #

  # Create local module directory (not tracked by git)
  mkdir -p "$DOTFILES_LOCAL_MODULE_PATH"

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

  # No need to update the package managers anymore
  export SKIP_PACKAGE_MANAGER_UPDATE="true"

  # Default modules
  local default_modules=(
    # needs to be installed first
    xdg
    base
    github
    # order doesn't matter
    bash
    carapace
    direnv
    fzf
    # git
    "$local_mod_name"
    mise
    starship
    xdg
    zoxide
    zsh
  )

  # Install dotfiles modules
  # shellcheck disable=SC2068
  dotfiles install ${default_modules[@]}

  # Set default shells
  DOTFILES_NO_SUDO=1 "$scripts_dir/set-default-shells.sh"
}

main "$@"
