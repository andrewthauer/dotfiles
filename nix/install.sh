#!/usr/bin/env bash

if [[ ! "$(command -v nix)" ]]; then
  sh <(curl -L https://nixos.org/nix/install) --daemon
fi
