#!/usr/bin/env bash

set -eou pipefail

main() {
  if [ "$(command -v nix)" ]; then
    echo "Nix is already installed"
  fi

  # https://nixos.org/download/
  # sh <(curl -L https://nixos.org/nix/install) --daemon

  # https://github.com/DeterminateSystems/nix-installer
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
}

main "$@"
