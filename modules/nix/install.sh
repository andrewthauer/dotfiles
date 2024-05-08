#!/usr/bin/env bash

if [ ! "$(command -v nix)" ]; then
  # https://nixos.org/download/
  # sh <(curl -L https://nixos.org/nix/install) --daemon

  # https://github.com/DeterminateSystems/nix-installer
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
fi
