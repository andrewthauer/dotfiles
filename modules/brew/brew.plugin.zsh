#!/bin/sh

brew_install_or_upgrade() {
  if brew_is_installed "$1"; then
    if brew_is_upgradable "$1"; then
      echo "Upgrading %s ..." "$1"
      brew upgrade "$@"
    else
      echo "Already using the latest version of %s. Skipping ..." "$1"
    fi
  else
    echo "Installing %s ..." "$1"
    brew install "$@"
  fi
}

brew_is_installed() {
  local name="$(brew_expand_alias "$1")"

  brew list -1 | grep -Fqx "$name"
}

brew_is_upgradable() {
  local name="$(brew_expand_alias "$1")"

  ! brew outdated --quiet "$name" >/dev/null
}

brew_tap() {
  brew tap "$1" 2> /dev/null
}

brew_expand_alias() {
  brew info "$1" 2>/dev/null | head -1 | awk '{gsub(/:/, ""); print $1}'
}

brew_launchctl_restart() {
  local name="$(brew_expand_alias "$1")"
  local domain="homebrew.mxcl.$name"
  local plist="$domain.plist"

  echo "Restarting %s ..." "$1"
  mkdir -p "$HOME/Library/LaunchAgents"
  ln -sfv "/usr/local/opt/$name/$plist" "$HOME/Library/LaunchAgents"

  if launchctl list | grep -Fq "$domain"; then
    launchctl unload "$HOME/Library/LaunchAgents/$plist" >/dev/null
  fi
  launchctl load "$HOME/Library/LaunchAgents/$plist" >/dev/null
}

# -------------------------------------
# brew cask (caskroom) stuff

brew_cask_is_installed() {
  local name="$(brew_cask_expand_alias "$1")"

  brew cask list -1 | grep -Fqx "$name"
}

brew_cask_is_upgradable() {
  local name="$(brew_cask_expand_alias "$1")"

  ! brew cask outdated --quiet "$name" >/dev/null
}

brew_cask_expand_alias() {
  brew cask info "$1" 2>/dev/null | head -1 | awk '{gsub(/:/, ""); print $1}'
}

brew_cask_install_or_upgrade() {
  if brew_cask_is_installed "$1"; then
    if brew_cask_is_upgradable "$1"; then
      echo "Upgrading %s ..." "$1"
      brew cask upgrade "$@"
    else
      echo "Already using the latest version of %s. Skipping ..." "$1"
    fi
  else
    echo "Installing %s ..." "$1"
    brew cask install "$@"
  fi
}
