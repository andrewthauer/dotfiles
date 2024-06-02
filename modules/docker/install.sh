#!/usr/bin/env bash

set -eou pipefail

install_macos() {
  # Source docker profile
  source "${DOTFILES_MODULES_DIR}/docker/.config/profile.d/docker.sh"

  # Setup config directories
  mkdir -p "${XDG_CONFIG_HOME}/docker"
  if [ ! -L "${HOME}/.docker" ]; then
    ln -s "${XDG_CONFIG_HOME}/docker" "${HOME}/.docker"
  fi

  # Install colima, docker, docker-compose and docker-buildx
  echo "Installing docker and colima..."
  brew install colima docker docker-compose docker-buildx

  # Setup docker-compose and set buildx as the default docker build engine
  echo "Setting up docker-compose and docker-buildx..."
  mkdir -p ~/.docker/cli-plugins
  ln -sfn "$(brew --prefix)"/opt/docker-buildx/bin/docker-buildx ~/.docker/cli-plugins/docker-buildx
  ln -sfn "$(brew --prefix)"/opt/docker-compose/bin/docker-compose ~/.docker/cli-plugins/docker-compose
  docker buildx install

  # Setup colima
  echo "Setting up colima..."
  ln -s "$HOME/.config/colima" "$HOME/.colima"
}

main() {
  case "$("$DOTFILES_BIN"/os-info --family)" in
    "macos")
      install_macos
      ;;
    *) ;;
  esac
}

main "$@"
