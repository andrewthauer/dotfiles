#!/usr/bin/env bash
# Summary
#   Install & setup this dotfiles repo
#
# Usage
#   ./install.sh
#
# Flags
#   --target | -t <dir>                 The target directory for the dotfiles repo
#   --setup-script | -s <path>          The custom setup command to run
#   --no-sudo                           Allow usage of sudo: 1 (no) or 0 (yes)
#   --verbose | -v                      Enable verbose logging
#
# Environmenet Variables
#   DOTFILES_HOME                       The target directory for the dotfiles repo
#   DOTFILES_NO_SUDO                    Allow usage of sudo: 1 (no) or 0 (yes)
#   DOTFILES_SETUP_SCRIPT               The custom setup command to run
#
# Examples
#   ./install.sh
#   curl -fsSL https://raw.githubusercontent.com/andrewthauer/dotfiles/main/install.sh | sh
#   curl -fsSL https://raw.githubusercontent.com/andrewthauer/dotfiles/main/install.sh | sh -- --target "$HOME/dotfiles"

set -eo pipefail

clone_dotfiles() {
  if [ ! -d "${DOTFILES_HOME}" ]; then
    echo "Cloning dotfiles repo..."
    git clone "https://github.com/andrewthauer/dotfiles.git" "$DOTFILES_HOME"
  fi
}

main() {
  case "$1" in
    --target | -t)
      DOTFILES_HOME="$2"
      shift 2
      ;;
    --setup-script | -s)
      DOTFILES_SETUP_SCRIPT="$2"
      shift 2
      ;;
    --no-sudo)
      DOTFILES_NO_SUDO=1
      shift 1
      ;;
    --verbose | -v)
      export DOTFILES_LOG_VERBOSE="true"
      shift 1
      ;;
    *) ;;
  esac

  # Determine if the install is being run locally of from a curl
  if [ "${BASH_SOURCE[0]}" = "$0" ]; then
    DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
  else
    DOTFILES_HOME="${DOTFILES_HOME:-$HOME/.dotfiles}"
  fi

  # Defaults
  export DOTFILES_HOME="${DOTFILES_HOME}"
  export DOTFILES_NO_SUDO="${DOTFILES_NO_SUDO:-0}"

  if [ -n "$DOTFILES_LOG_VERBOSE" ]; then
    echo "DOTFILES_HOME: $DOTFILES_HOME"
    echo "DOTFILES_NO_SUDO: $DOTFILES_NO_SUDO"
    echo "DOTFILES_SETUP_SCRIPT: $DOTFILES_SETUP_SCRIPT"
  fi

  # Clone and initialize dotfiles env
  clone_dotfiles

  # Use xdg spec
  source "${DOTFILES_HOME}/lib/xdg.sh"

  # Run custom setup script if provided
  if [ -n "$DOTFILES_SETUP_SCRIPT" ]; then
    "$DOTFILES_SETUP_SCRIPT"
  elif [ "$REMOTE_CONTAINERS" == "true" ] || [ "$DEVPOD" == "true" ]; then
    # Install as a devcontainer
    "$DOTFILES_HOME/scripts/setup-devcontainer.sh"
  else
    # Run autodetected setup script
    case "$(os-info --family)" in
      "macos") "$DOTFILES_HOME/scripts/setup-macos.sh" ;;
      "debian") "$DOTFILES_HOME/scripts/setup-linux.sh" ;;
      *) echo "No OS specific setup script" ;;
    esac
  fi
}

# Run the script
main "$@"
