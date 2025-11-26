#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

install_devpod() {
  # Install devpod
  case "$(os-info --family)" in
    darwin)
      pkg --type brew install devpod
      configure_devpod
      ;;
    *) echo "Not implemented for this OS" ;;
  esac
}

configure_devpod() {
  # Use xdg
  export DEVPOD_HOME="$XDG_CONFIG_HOME/devpod"

  # Set some defaults
  devpod provider add docker
  devpod provider use docker
  devpod context set-options -o SSH_CONFIG_PATH="${XDG_CONFIG_HOME}/ssh/config.d/devpod"

  # Customizations
  devpod context set-options \
    -o DOTFILES_URL=https://github.com/andrewthauer/dotfiles \
    -o DOTFILES_SCRIPT=scripts/setup-devcontainer.sh
}

main() {
  install_devpod
}

main "$@"
