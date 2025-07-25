#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

install_devpod() {
  # local os arch
  os="$(os-info --os)"
  arch="$(os-info --arch)"
  [ "$arch" == "x86_64" ] && arch="amd64"

  # Use xdg
  export DEVPOD_HOME="$XDG_CONFIG_HOME/devpod"

  # Install devpod
  case "$(os-info --family)" in
    macos)
      brew install devpod
      ;;
    *)
      echo "Unsupported OS: $os"
      exit 1
      ;;
  esac

  # Set some defaults
  devpod provider add docker
  devpod provider use docker
  devpod context set-options -o SSH_CONFIG_PATH="${XDG_CONFIG_HOME}/ssh/config.d/devpod"

  # Customizations
  devpod context set-options -o DOTFILES_URL=https://github.com/andrewthauer/dotfiles
}

main() {
  install_devpod
}

main "$@"
