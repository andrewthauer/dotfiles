#!/usr/bin/env bash

set -eou pipefail

install_devpod() {
  # local os arch
  os="$("$DOTFILES_DIR"/bin/os-info --os)"
  arch="$("$DOTFILES_DIR"/bin/os-info --arch)"
  [ "$arch" == "x86_64" ] && arch="amd64"

  # Use xdg
  export DEVPOD_HOME="$XDG_CONFIG_HOME/devpod"

  # Install devpod
  case "$("$DOTFILES_DIR"/bin/os-info --family)" in
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
  # devpod ide use zed
  # TODO: Set dotfiles defaults
  # devpod context set-options
}

main() {
  install_devpod
}

main "$@"
