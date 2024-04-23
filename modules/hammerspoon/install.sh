#!/usr/bin/env bash

main() {
  echo "Installing Hammerspoon..."
  brew list hammerspoon || brew install hammerspoon

  echo "Configuring Hammerspoon..."
  defaults write org.hammerspoon.Hammerspoon MJConfigFile "$XDG_CONFIG_HOME/hammerspoon/init.lua"

  echo "Installing SpoonInstall..."
  curl -L0 \
    https://github.com/Hammerspoon/Spoons/raw/master/Spoons/SpoonInstall.spoon.zip |
    tar -zx -C ~/.config/hammerspoon/Spoons
}

main "$@"
