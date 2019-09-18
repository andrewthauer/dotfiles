#!/usr/bin/env bash
#
# Setup homebrew
#

set -e

# Prompt for admin password upfront
sudo -v

# Check if homebrew is installed
if [[ ! -x "$(command -v brew)" ]]; then
  if [[ "${OSTYPE}" == darwin* ]]; then
    # Take ownership of /usr/local
    # sudo chown -R "${USER}":admin /usr/local

    # Install standard homebrew
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  elif [[ "${OSTYPE}" == linux* ]]; then
    # Make sure this is in the path
    export PATH="/home/linuxbrew/.linuxbrew/bin:${PATH}"

    # Install linuxbrew
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"
  fi
fi

# Install brews using brew bundle (uses the ~/.Brewfile)
if [[ -x "$(command -v brew)" ]]; then
  echo "Do you want run brew bundle [y/N]?"
  read answer
  case "${answer}" in [yY]|[yY][eE][sS])
    brew bundle --file="${DOTFILES_DIR}/homebrew/.Brewfile"
  esac
fi
