#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

install_macos() {
  # Setup config directories
  mkdir -p "${XDG_CONFIG_HOME}/docker"
  if [ ! -L "${HOME}/.docker" ]; then
    ln -s "${XDG_CONFIG_HOME}/docker" "${HOME}/.docker"
  fi

  # Install colima, docker, docker-compose and docker-buildx
  echo "Installing docker and colima..."
  DOCKER_APPS="colima docker docker-compose docker-buildx"
  # shellcheck disable=SC2086
  pkg install --type brew $DOCKER_APPS

  # Setup docker-compose and set buildx as the default docker build engine
  echo "Setting up docker-compose and docker-buildx..."
  mkdir -p ~/.docker/cli-plugins
  ln -sfn "$(brew --prefix)"/opt/docker-buildx/bin/docker-buildx ~/.docker/cli-plugins/docker-buildx
  ln -sfn "$(brew --prefix)"/opt/docker-compose/bin/docker-compose ~/.docker/cli-plugins/docker-compose
  docker buildx install
}

install_model_runner() {
  mise install -g "go:github.com/docker/cli-model@latest"
  ln -sfn "$(mise which model-cli)" ~/.docker/cli-plugins/docker-model
  docker model install-runner
}

main() {
  case "$(os-info --family)" in
    darwin)
      install_macos
      # install_model_runner
      ;;
    *) echo "Not implemented for this OS" ;;
  esac
}

main "$@"
