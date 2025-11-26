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

install_op_module() {
  # Explain the op module before prompting
  echo "The 'op' module integrates 1Password with the shell and SSH."
  echo "NOTE: This requires manually enabling the SSH agent in the 1Password app first."
  echo "If you haven't done this, or if you are unsure, select 'N'."

  prompt_for_action "1Password (op) module" "dotfiles install op" "dotfiles module list | grep -q '^op$'"
}

# Main function to set up the macOS environment
main() {
  local modules_dir="$DOTFILES_HOME/modules"
  local scripts_dir="$DOTFILES_HOME/scripts"
  local modules_file
  modules_file="$(dotfiles module file-path)"

  # Create local module directory (not tracked by git)
  mkdir -p "$modules_dir/local"

  # Setup key environment variables for macOS (e.g. XDG_CONFIG_HOME)
  "$modules_dir/macos/.local/bin/launchctl-env.sh"

  # Install homebrew and brews from brewfile
  "$modules_dir/homebrew/install.sh"

  # shellcheck disable=SC1091 source=../modules/homebrew/.config/homebrew/shellenv.sh
  source "$modules_dir/homebrew/.config/homebrew/shellenv.sh"

  # No need to update the package managers anymore
  export SKIP_PACKAGE_MANAGER_UPDATE="true"

  # Default modules
  local default_modules=(
    # these need to be installed first
    xdg
    base
    ssh
    github
    mise
    # order does not matter
    bash
    bat
    deno
    direnv
    docker
    eza
    fzf
    git
    go
    gpg
    ghostty
    hammerspoon
    homebrew
    jujutsu
    karabiner
    local
    macos
    neovim
    nodejs
    nushell
    python
    ripgrep
    ruby
    rust
    starship
    xdg
    zed
    zoxide
    zed
    zsh
  )

  # Install dotfiles modules
  # shellcheck disable=SC2068
  dotfiles install --file "$modules_file" ${default_modules[@]}

  #
  # Extra stuff
  #

  # Install 1Password module (op)
  install_op_module

  # Make firefox default browser
  echo "Setting Firefox Developer Edition as the default browser..."
  open -a "Firefox Developer Edition" --background --args -silent -nosplash -setDefaultBrowser

  # Install applications
  prompt_for_action "1password" "brew install --cask 1password" "brew list --cask 1password"
  prompt_for_action "NeoVim" "$modules_dir/neovim/install.sh" "command -v nvim"
  prompt_for_action "Hammerspoon" "$modules_dir/hammerspoon/install.sh" "test -d /Applications/Hammerspoon.app"
  prompt_for_action "Karabiner-Elements" "$modules_dir/karabiner/install.sh" "test -d /Applications/Karabiner-Elements.app"

  # Setup macos defaults
  "$scripts_dir/macos-defaults.sh"

  # Set default shells
  prompt_for_action "change default shells" "$scripts_dir/set-default-shells.sh"
}

main "$@"
