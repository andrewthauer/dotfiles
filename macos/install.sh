#!/usr/bin/env bash

set -e

# Set the target directory
export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

# Prompt for admin password upfront
sudo -v

# Install pre-requisites
xcode-select --install

# Clone this repo
if [[ ! -d "${DOTFILES_DIR}" ]]; then
  git clone "https://github.com/andrewthauer/dotfiles.git" ~/.dotfiles
fi

# Install homebrew
${DOTFILES_DIR}/homebrew/install.sh
BREW_PREFIX=$(brew --prefix)

# Add homebrew shell versions and change default shell
grep -q "${BREW_PREFIX}/bin/bash" /etc/shells && echo "${BREW_PREFIX}/bin/bash" | sudo tee -a /etc/shells
grep -q "${BREW_PREFIX}/bin/zsh" /etc/shells && echo "${BREW_PREFIX}/bin/zsh" | sudo tee -a /etc/shells
chsh -s "${BREW_PREFIX}/bin/zsh"

# Rename existing dotfiles
files=(
  ~/.profile
  ~/.bash_profile
  ~/.bashrc
  ~/.zlogin
  ~/.zlogout
  ~/.zshenv
  ~/.zprofile
  ~/.zshrc
)
for file in ${files[@]}; do
  [[ ! -L "${file}" ]] && mv "${file}" "${file}.old"
done

# Setup the dotfiles
pushd ${DOTFILES_DIR} >/dev/null
make
popd > /dev/null

# macOS default settings
${DOTFILES_DIR}/macos/setting/defaults.sh

echo "Start zsh ..."
zsh
