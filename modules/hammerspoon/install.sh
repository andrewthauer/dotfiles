#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

install_hammerspoon() {
  echo "Installing Hammerspoon..."
  brew list hammerspoon || brew install hammerspoon
}

install_spoons() {
  echo "Installing SpoonInstall..."
  curl -L0 \
    https://github.com/Hammerspoon/Spoons/raw/master/Spoons/SpoonInstall.spoon.zip |
    tar -zx -C ~/.config/hammerspoon/Spoons
}

configire_hammerspoon() {
  echo "Configuring Hammerspoon..."
  defaults write org.hammerspoon.Hammerspoon MJConfigFile "$XDG_CONFIG_HOME/hammerspoon/init.lua"
}

main() {
  case "$(os-info --family)" in
    "macos")
      install_hammerspoon
      install_spoons
      configire_hammerspoon
      ;;
    *)
      echo "Hammerspoon is only available on macOS"
      exit 1
      ;;
  esac
}

main "$@"
