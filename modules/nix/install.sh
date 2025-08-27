#!/usr/bin/env bash

set -eou pipefail

install_nix() {
  # https://github.com/DeterminateSystems/nix-installer
  # curl -fsSL https://install.determinate.systems/nix | sh -s -- install --determinate

  # Offical nix experimental installer
  curl -L https://github.com/NixOS/experimental-nix-installer/releases/download/0.27.0/nix-installer.sh | sh -s -- install
}

install_nix_pkgs() {
  # Upgrade bash
  nix-env --install --attr bashInteractive -f https://github.com/NixOS/nixpkgs/tarball/nixpkgs-unstable
}

main() {
  if [ "$(command -v nix)" ]; then
    echo "Nix is already installed"
  else
    install_nix
    install_nix_pkgs
  fi
}

main "$@"
