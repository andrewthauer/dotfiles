#!/usr/bin/env bash

set -eou pipefail

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." &>/dev/null && pwd)"
PATH="$DOTFILES_HOME/bin:$PATH"

install_hammerspoon() {
  echo "Installing Hammerspoon..."
  pkg install hammerspoon --type brew hammerspoon
}

install_spoons() {
  echo "Installing SpoonInstall..."
  mkdir -p ~/.config/hammerspoon/Spoons
  curl -L0 \
    https://github.com/Hammerspoon/Spoons/raw/master/Spoons/SpoonInstall.spoon.zip |
    tar -zx -C ~/.config/hammerspoon/Spoons
}

configire_hammerspoon() {
  echo "Configuring Hammerspoon..."
  defaults write org.hammerspoon.Hammerspoon MJConfigFile "$XDG_CONFIG_HOME/hammerspoon/init.lua"
}

setup_launch_on_startup() {
  echo "Setting up Hammerspoon to launch on startup..."
  osascript -e 'tell application "System Events" to make new login item at end with properties {path:"/Applications/Hammerspoon.app", hidden:false}'
}

launch_hammerspoon() {
  echo "Launching Hammerspoon..."
  if ! pgrep -x "Hammerspoon" >/dev/null; then
    open /Applications/Hammerspoon.app
  else
    echo "Hammerspoon is already running"
  fi
}

main() {
  case "$(os-info --family)" in
    darwin)
      if brew list hammerspoon &>/dev/null; then
        echo "Hammerspoon already installed, skipping..."
        return 0
      fi
      install_hammerspoon
      install_spoons
      configire_hammerspoon
      dotfiles module add hammerspoon
      setup_launch_on_startup
      launch_hammerspoon
      ;;
    *)
      echo "Hammerspoon is only available on macOS"
      exit 1
      ;;
  esac
}

main "$@"
