#!/usr/bin/env bash
# Summary:
#   Install & setup this dotfiles repo
#
# Usage:
#   ./install.sh
#
# Environmenet Variables:
#   DOTFILES_DIR                        The target directory for the dotfiles repo
#   DOTFILES_DISABLE_SUDO               Allow usage of sudo: 1 (no) or 0 (yes)
#
# Examples:
#   ./install.sh
#   DOTFILES_DIR="$HOME/my-dotfiles" ./install.sh
#   sh -c "$(curl -fsSL https://raw.githubusercontent.com/andrewthauer/dotfiles/main/install.sh)"

set -eo pipefail

export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
export DOTFILES_BIN="$DOTFILES_DIR/bin"
export DOTFILES_DISABLE_SUDO="${DOTFILES_DISABLE_SUDO:-0}"

clone_dotfiles() {
  if [ ! -d "${DOTFILES_DIR}" ]; then
    echo "Cloning dotfiles repo..."
    git clone "https://github.com/andrewthauer/dotfiles.git" "$DOTFILES_DIR"

    # Ensure repo is using the ssh remote
    pushd "${DOTFILES_DIR}" >/dev/null
    git remote set-url origin git@github.com:andrewthauer/dotfiles.git
    popd >/dev/null
  fi
}

# shellcheck disable=SC2317
backup_dotfiles() {
  # Rename existing dotfiles
  local files=(~/.bash_profile ~/.bashrc ~/.zshenv ~/.zshrc)

  # move existing files
  for file in "${files[@]}"; do
    if [ -f "${file}" ] && [ ! -L "${file}" ]; then
      mv "${file}" "${file}.bak"
    fi
  done
}

main() {
  echo "DOTFILES_DIR: $DOTFILES_DIR"
  echo "DOTFILES_DISABLE_SUDO: $DOTFILES_DISABLE_SUDO"

  # Clone and initialize dotfiles env
  clone_dotfiles
  source "${DOTFILES_DIR}"/lib/init.sh

  # Backup existing dotfiles
  backup_dotfiles

  # Run OS specific setup script
  case "$("$DOTFILES_BIN"/os-info --family)" in
    "macos") "$DOTFILES_DIR/scripts/setup-macos.sh" ;;
    "debian") "$DOTFILES_DIR/scripts/setup-linux.sh" ;;
    *) echo "No OS specific setup script";;
  esac

  # Set default shells
  "$DOTFILES_DIR/scripts/set-default-shells.sh"
}

# Run the script
main "$@"
exit 0
