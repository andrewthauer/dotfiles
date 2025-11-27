#!/usr/bin/env bash

set -eou pipefail

install_nix() {
  # https://github.com/DeterminateSystems/nix-installer
  # curl -fsSL https://install.determinate.systems/nix | sh -s -- install --determinate

  # Offical nix experimental installer
  curl --proto '=https' --tlsv1.2 -sSf -L https://artifacts.nixos.org/experimental-installer | sh -s -- install
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
