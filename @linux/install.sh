#!/usr/bin/env bash

set -e

# Get the appropriate package manager script
get_os_family() {
  declare -A os_info;
  os_info[/etc/debian_version]="debian"
  os_info[/etc/fedora-release]="fedora"
  os_info[/etc/redhat-release]="rhel"
  os_info[/etc/arch-release]="arch"
  os_info[/etc/alpine-release]="alpine"
  for f in ${!os_info[@]}; do
    [[ -f $f ]] && os_family="${os_info[$f]}"
  done
  echo "${os_family}"
}

install_dependencies() {
  os_family=$(get_os_family)
  core_packages="curl file git"
  dotfiles_packages="bash make neovim stow zsh"
  packages="${core_packages} ${dotfiles_packages}"

  if [[ "${os_family}" == "debian" ]]; then
    sudo apt-get update && sudo apt-get install -y build-essential ${packages}
  elif [[ "${os_family}" == "fedora" ]]; then
    sudo dnf groupinstall "Development Tools" && sudo dnf install -y ${packages} libxcrypt-compat
  elif [[ "${os_family}" == "rhel" ]]; then
    sudo yum groupinstall "Development Tools" && sudo yum install -y ${packages}
  elif [[ "${os_family}" == "arch" ]]; then
    sudo pacman -S base-devel ${packages}
  else
    echo "OS family: '${os_family}' not supported"
    exit 1
  fi
}

clone_dotfiles() {
  # Set the target directory
  export DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

  # Clone this repo
  if [[ ! -d "${DOTFILES_DIR}" ]]; then
    git clone "https://github.com/andrewthauer/dotfiles.git" ~/.dotfiles
  fi
}

install_brew() {
  confirm_cmd="${DOTFILES_DIR}/bin/confirm"
  if $confirm_cmd "Do you want to install dependencies with linuxbrew"; then
    # Install homebrew & default dependencies
    ${DOTFILES_DIR}/homebrew/install.sh
  fi
}

setup_zsh() {
  # Use brew or fallback to native
  BIN_PREFIX="$(brew --prefix)"
  if [[ -z "${BIN_PREFIX}" ]]; then
    BIN_PREFIX="/usr"
  fi

  # Add availble shells
  grep -q "${BIN_PREFIX}/bin/bash" /etc/shells && echo "${BIN_PREFIX}/bin/bash" | sudo tee -a /etc/shells
  grep -q "${BIN_PREFIX}/bin/zsh" /etc/shells && echo "${BIN_PREFIX}/bin/zsh" | sudo tee -a /etc/shells

  # Change default shell to zsh
  chsh -s "${BIN_PREFIX}/bin/zsh"
}

setup_dotfiles() {
  # Rename existing dotfiles
  files=(~/.profile ~/.bash_profile ~/.bashrc ~/.zlogin ~/.zlogout ~/.zshenv ~/.zprofile ~/.zshrc)
  for file in ${files[@]}; do
    if [[ -f ${file} && ! -L "${file}" ]]; then
      mv "${file}" "${file}.old"
    fi
  done

  # Setup the dotfiles
  pushd ${DOTFILES_DIR} > /dev/null
  make
  popd > /dev/null
}

main() {
  # Prompt for admin password upfront
  sudo -v

  # Install
  install_dependencies
  clone_dotfiles
  install_brew
  setup_dotfiles

  # Start zsh
  echo "Starting zsh ..."
  zsh
}

main "$@"
exit 0
