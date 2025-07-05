#!/usr/bin/env bash

set -eo pipefail

DOTFILES_HOME="${DOTFILES_HOME:-$(cd "$(dirname "${BASH_SOURCE[0]}")/.." &>/dev/null && pwd)}"
source "${DOTFILES_HOME}/lib/xdg.sh"
PATH="${DOTFILES_HOME}/bin:${XDG_BIN_HOME}:${PATH}"

# Prompt for admin password upfront (only if not already running as sudo)
# if ! sudo -n true 2>/dev/null; then
#   sudo -v
# fi

# Function to prompt before performing an action
prompt_for_action() {
  local name="$1"
  local command="$2"
  local check_command="$3"

  # Check if action is required (if check command provided)
  if [[ -n "$check_command" ]]; then
    if eval "$check_command" &>/dev/null; then
      echo "$name is already installed/configured, skipping."
      return 0
    fi
  fi

  if read -p "Do you want to install $name? (y/N): " -n 1 -r && echo; then
    if [[ $REPLY =~ ^[Yy]$ ]]; then
      echo "Running action..."
      eval "$command"
    fi
  fi
}

link_dotfiles() {
  # Default modules
  local default_modules=(
    _base
    bash
    bat
    deno
    direnv
    docker
    fzf
    git
    github
    go
    gpg
    ghostty
    hammerspoon
    homebrew
    jujutsu
    karabiner
    local
    macos
    mise
    neovim
    nodejs
    python
    ripgrep
    ruby
    rust
    ssh
    starship
    xdg
    zed
    zoxide
    zsh
  )

  # Write modules file
  if [ ! -f "$mod_file" ]; then
    # shellcheck disable=SC2068
    dotfiles module write-file --file "$mod_file" ${default_modules[@]}
  fi

  # Link dotfiles
  dotfiles module link --file "$mod_file"
}

install_op_module() {
  # Explain the op module before prompting
  echo "The 'op' module integrates 1Password with the shell and SSH."
  echo "NOTE: This requires manually enabling the SSH agent in the 1Password app first."
  echo "If you haven't done this, or if you are unsure, select 'N'."

  prompt_for_action "1Password (op) module" "dotfiles module add op" "dotfiles module list | grep -q '^op$'"
}

# Main function to set up the macOS environment
main() {
  # TODO: set terminal defaults early
  # font, etc.

  local mod_dir="$DOTFILES_HOME/modules"
  local scripts_dir="$DOTFILES_HOME/scripts"
  local mod_file
  mod_file="$(dotfiles module file-path)"

  # Setup key environment variables for macOS (e.g. XDG_CONFIG_HOME)
  "$mod_dir/macos/.local/bin/launchctl-env.sh"

  # Setup github known host
  "$mod_dir/github/install.sh"

  # Base setup
  "$mod_dir/_base/install.sh"
  mkdir -p "$mod_dir/local"

  # Link dotfile
  link_dotfiles

  # Install & load Homebrew shellenv
  "$mod_dir/homebrew/install.sh"
  # shellcheck source=/dev/null
  source "$mod_dir/homebrew/.config/homebrew/shellenv.sh"

  # Install other tools and modules
  "$mod_dir/macos/install.sh"
  "$mod_dir/docker/install.sh"
  "$mod_dir/nushell/install.sh"
  "$mod_dir/mise/install.sh"
  "$mod_dir/zed/install.sh"

  # Install 1Password module (op)
  install_op_module

  # Make firefox default browser
  echo "Setting Firefox Developer Edition as the default browser..."
  open -a "Firefox Developer Edition" --background --args -silent -nosplash -setDefaultBrowser

  # Install applications
  prompt_for_action "1password" "brew install --cask 1password" "brew list --cask 1password"
  prompt_for_action "NeoVim" "$mod_dir/neovim/install.sh" "command -v nvim"
  prompt_for_action "Hammerspoon" "$mod_dir/hammerspoon/install.sh" "test -d /Applications/Hammerspoon.app"
  prompt_for_action "Karabiner-Elements" "$mod_dir/karabiner/install.sh" "test -d /Applications/Karabiner-Elements.app"

  # Setup macos defaults
  "$scripts_dir/macos-defaults.sh"

  # Set default shells
  prompt_for_action "change default shells" "$scripts_dir"/set-default-shells.sh
}

main "$@"
