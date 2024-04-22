#!/usr/bin/env bash

main() {
  defaults write org.hammerspoon.Hammerspoon MJConfigFile "$(XDG_CONFIG_HOME)/hammerspoon/init.lua"

  curl -L0 \
    https://github.com/Hammerspoon/Spoons/raw/master/Spoons/SpoonInstall.spoon.zip |
    tar -zx -C ~/.config/hammerspoon/Spoons
}

main "$@"
